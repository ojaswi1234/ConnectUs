// lib/main.dart
import 'package:ConnectUs/pages/AI_page.dart';
import 'package:ConnectUs/pages/config/account.dart';
import 'package:ConnectUs/pages/home/about.dart';
import 'package:ConnectUs/models/contact.dart';
import 'package:ConnectUs/services/ferry_client.dart';
import 'package:flutter/foundation.dart'; // REQUIRED for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:ConnectUs/services/AuthChecker.dart';
import 'package:ConnectUs/pages/auth/profile.dart';
import 'package:ConnectUs/pages/config/settings.dart';
import 'package:ConnectUs/pages/home/home.dart';
import 'package:ConnectUs/pages/landing.dart';
import 'package:ConnectUs/pages/auth/login.dart';
import 'package:ConnectUs/pages/auth/register.dart';
import 'package:ConnectUs/pages/auth/registerPhone.dart';
import 'package:ConnectUs/pages/contacts_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ferry/ferry.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io'; // Safe to keep, but must use conditionally
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
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
      print('Folder creation failed (Normal on Web): $e');
    }
  }

  try {
    await _initializeApp(customPath).timeout(const Duration(seconds: 15));
  } catch (e) {
    print('Initialization error: $e');
  }

  final client = initFerryClient();
  runApp(
    Provider<Client>(
      create: (_) => client,
      child: const MainApp(),
    ),
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
  await Hive.openBox<Contact>('contacts');
  
  // Ensure local_chats box is open (needed for chatArea)
  await Hive.openBox('local_chats');

  try {
    // Note: On web, assets/.env might return 404. Consider using --dart-define for prod.
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    debug: false,
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateOnlineStatus(true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateOnlineStatus(true);
    } else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _updateOnlineStatus(false);
    }
  }

  Future<void> _updateOnlineStatus(bool isOnline) async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client
            .from('users')
            .update({'is_online': isOnline})
            .eq('id', user.id);
      }
    } catch (e) {
      // Fail silently
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
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
        '/getStarted': (context) => Register(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        'login-callback': (context) => const AuthChecker(),
        '/contacts': (context) => ContactsPage(
              registeredContacts: [],
              nonRegisteredContacts: [],
              onContactTap: (contact) {},
              onInviteContact: (contact) {},
              isLoading: false,
            ),
        '/registerPhone': (context) => RegisterPhone(),
        '/profile': (context) => Profile(),
        '/settings': (context) => Settings(),
        '/ai': (context) => AIPage(),
        '/about': (context) => About(),
        '/account': (context) => Account(),
      },
    );
  }
}