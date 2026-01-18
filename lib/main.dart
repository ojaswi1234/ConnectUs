// main.dart
import 'package:ConnectUs/pages/AI_page.dart';
import 'package:ConnectUs/pages/config/account.dart';
import 'package:ConnectUs/pages/home/about.dart';
import 'package:ConnectUs/models/contact.dart';
import 'package:ConnectUs/services/ferry_client.dart';
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
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//import 'package:ConnectUs/services/socketService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  // Create the specific folder 'ConnectUs'
  final connectUsDir = Directory('${appDocDir.path}/ConnectUs');
  if (!await connectUsDir.exists()) {
    await connectUsDir.create(recursive: true);
  }
  // --------------------------------

  try {
    // Pass the custom directory to the app initialization
    await _initializeApp(connectUsDir.path)
        .timeout(const Duration(seconds: 15));
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

Future<void> _initializeApp(String customPath) async {
  // Performance optimization: Enable GPU rendering

  debugProfileBuildsEnabled = false;
  debugProfilePaintsEnabled = false;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive
  Hive.init(customPath);
  // ---------------------------------------------------------------

  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox<Contact>('contacts');
  try {
    // 1. Point to the correct asset path
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    debug: false,
  );

  // Initialize socket service (don't await - let it connect in background)
  //SocketService().initializeSocket();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // Performance optimizations
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      theme: ThemeData(
        // Pre-cache theme data for better performance
        useMaterial3: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
      routes: {
        '/': (context) =>
            const AuthChecker(), // Use AuthChecker for session persistence
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
