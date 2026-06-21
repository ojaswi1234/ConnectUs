// lib/main.dart
import 'dart:async';
import 'package:ConnectUs/pages/ai_page.dart';
import 'package:ConnectUs/pages/config/account.dart';
import 'package:ConnectUs/pages/home/about.dart';
import 'package:ConnectUs/models/contact.dart';
import 'package:flutter/foundation.dart'; // REQUIRED for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:ConnectUs/services/AuthChecker.dart';
import 'package:ConnectUs/pages/auth/profile.dart';
import 'package:ConnectUs/pages/config/settings.dart';
import 'package:ConnectUs/pages/home/home.dart';
import 'package:ConnectUs/pages/landing.dart';
import 'package:ConnectUs/pages/auth/login.dart';
import 'package:ConnectUs/pages/auth/register.dart';
import 'package:ConnectUs/pages/auth/register_phone.dart';
import 'package:ConnectUs/pages/contacts_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io'; // Safe to keep, but must use conditionally
import 'package:path_provider/path_provider.dart';
import 'package:ConnectUs/providers/call_provider.dart';
import 'package:ConnectUs/pages/chat/incoming_call_screen.dart';
import 'package:ConnectUs/services/encryption_key_manager.dart';
import 'package:ConnectUs/services/security_services.dart';
import 'package:ConnectUs/services/call_notification_service.dart';
import 'package:ConnectUs/pages/chat/voice.dart';
import 'package:ConnectUs/pages/chat/video.dart';
import 'package:ConnectUs/services/chat_sync_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main(dynamic wiget) async {
  WidgetsFlutterBinding.ensureInitialized();

  String? customPath;

  // FIX 2: Only create folder if NOT on web
  if (!kIsWeb) {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final connectUsDir = Directory('${appDocDir.path}/ConnectUs');
      if (!await connectUsDir.exists()) {
        await connectUsDir.create(recursive: true);
      }
      customPath = connectUsDir.path;
    } catch (e) {
      Logger(printer: PrettyPrinter()).e('Error creating custom path: $e');
    }
  }

  try {
    await _initializeApp(customPath).timeout(const Duration(seconds: 15));
  } catch (e) {
    Logger(printer: PrettyPrinter()).e('Error initializing app: $e');
  }
  

  runApp(
    const ProviderScope(child: MainApp()),
  );
}

Future<void> _initializeApp(String? customPath) async {
  debugProfileBuildsEnabled = false;
  debugProfilePaintsEnabled = false;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // FIX 3: Initialize Hive safely (Web uses IndexedDB automatically)
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    await Hive.initFlutter(customPath);
  }

  Hive.registerAdapter(ContactAdapter());
  
  // Initialize Encryption
  final encryptionKey = await EncryptionKeyManager().getOrCreateEncryptionKey();
  SecurityService.initialize(encryptionKey);
  
  // Open contacts (assuming we might encrypt it later, but keeping as is for backward compatibility or we can just leave it unencrypted)
  await Hive.openBox<Contact>('contacts');

  // Ensure local_chats box is open with encryption
  try {
    await Hive.openBox('local_chats', encryptionCipher: HiveAesCipher(encryptionKey));
  } catch (e) {
    // If it fails (e.g. was unencrypted before), delete and recreate
    Logger(printer: PrettyPrinter()).w('Failed to open local_chats with encryption. Deleting old box...');
    await Hive.deleteBoxFromDisk('local_chats');
    await Hive.openBox('local_chats', encryptionCipher: HiveAesCipher(encryptionKey));
  }
  
  await Hive.openBox('graphql_cache');

  try {
    // Note: On web, assets/.env might return 404. Consider using --dart-define for prod.
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    Logger(printer: PrettyPrinter()).e('Error loading .env: $e');
  }

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    debug: false,
  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  Timer? _heartbeatTimer;
  StreamSubscription? _incomingCallSub;
  ChatSyncService? _chatSync;
  StreamSubscription? _syncSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateOnlineStatus(true);
    _startHeartbeat();

    // Initialize chat sync
    _initChatSync();

    CallNotificationService.initialize(
      onAccept: (payload) async {
        final parts = payload.split('|');
        final callType = parts[0];
        final callerName = parts[1];
        
        await CallNotificationService.cancelCallNotification();
        final callService = ref.read(callServiceProvider);
        await callService.acceptCall();

        if (navigatorKey.currentContext != null) {
          Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (_) => callType == 'video'
                  ? Video(userName: callerName, callService: callService)
                  : Voice(userName: callerName, callService: callService),
            ),
          );
        }
      },
      onDecline: (payload) async {
        await CallNotificationService.cancelCallNotification();
        ref.read(callServiceProvider).declineCall();
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(callServiceProvider).initSignaling();
      _incomingCallSub = ref.read(callServiceProvider).incomingCallStream.listen((callData) async {
        final callerName = callData['caller'] ?? 'Unknown Caller';
        final callType = callData['callType'] ?? 'voice';
        final roomId = callData['roomId'] ?? 'unknown_room';

        await CallNotificationService.showIncomingCall(
          callerName: callerName,
          callType: callType,
          roomId: roomId,
        );

        if (navigatorKey.currentContext != null) {
          showDialog(
            context: navigatorKey.currentContext!,
            barrierDismissible: false,
            builder: (_) => IncomingCallScreen(callData: callData),
          );
        }
      });
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _updateOnlineStatus(true);
    });
  }

  Future<void> _initChatSync() async {
    _chatSync = ChatSyncService();
    await _chatSync!.initialize();
    await _chatSync!.fetchMissedMessages(); // Catch up on startup
  }

  @override
  void dispose() {
    _heartbeatTimer?.cancel();
    _incomingCallSub?.cancel();
    _syncSub?.cancel();
    _chatSync?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _updateOnlineStatus(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateOnlineStatus(true);
      _chatSync?.fetchMissedMessages(); // Catch up when coming back online
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _updateOnlineStatus(false);
      // Flush all pending local messages to Supabase before the OS sleeps the app.
      ChatSyncService().syncAllLocalChatsToSupabase();
    }
  }

  Future<void> _updateOnlineStatus(bool isOnline) async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client
            .from('users')
            .update({'is_online': isOnline}).eq('id', user.id);
      }
    } catch (e) {
      // Fail silently
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      routes: {
        '/': (context) => const AuthChecker(),
        '/landing': (context) => const Landing(),
        '/getStarted': (context) => const Register(),
        '/login': (context) => const Login(),
        '/home': (context) => const Home(),
        'login-callback': (context) => const AuthChecker(),
        '/contacts': (context) => ContactsPage(
              registeredContacts: const [],
              nonRegisteredContacts: const [],
              onContactTap: (contact) {},
              onInviteContact: (contact) {},
              isLoading: false,
            ),
        '/registerPhone': (context) => const RegisterPhone(),
        '/profile': (context) => const Profile(),
        '/settings': (context) => const Settings(),
        '/ai': (context) => const AIPage(),
        '/about': (context) => About(),
        '/account': (context) => const Account(),
      },
    );
  }
}
