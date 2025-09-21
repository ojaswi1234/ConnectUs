// main.dart
import 'package:Sutra/models/contact.dart';
import 'package:Sutra/pages/AI_page.dart';
import 'package:Sutra/pages/home/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

import 'package:Sutra/services/AuthChecker.dart';
import 'package:Sutra/pages/auth/profile.dart';
import 'package:Sutra/pages/config/settings.dart';
import 'package:Sutra/pages/home/home.dart';
import 'package:Sutra/pages/landing.dart';
import 'package:Sutra/pages/auth/login.dart';
import 'package:Sutra/pages/auth/register.dart';
import 'package:Sutra/pages/auth/loginPhone.dart';
import 'package:Sutra/pages/auth/registerPhone.dart';
import 'package:Sutra/pages/contacts_page.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:Sutra/services/socketService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Add timeout to prevent infinite waiting and wrap in try-catch
    await _initializeApp().timeout(const Duration(seconds: 15));
  } catch (e) {
    print('Initialization error: $e');
    // Continue launching the app even if some services fail
    // The app will handle missing services gracefully
  }

  runApp(const MainApp());
}

Future<void> _initializeApp() async {
  // Performance optimization: Enable GPU rendering
  debugProfileBuildsEnabled = false;
  debugProfilePaintsEnabled = false;
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox<Contact>('contacts');

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://hkxvlihyacqpfdviyycy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhreHZsaWh5YWNxcGZkdml5eWN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4OTQxMzksImV4cCI6MjA3MTQ3MDEzOX0.vQDz72Zu6IVglI43t2VUTYVxzeMZbBPRki9zm4_VxF8',
    debug: false,
  );

  // Initialize socket service (don't await - let it connect in background)
  SocketService().initializeSocket();
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
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
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
        '/': (context) => const AuthChecker(), // Use AuthChecker for session persistence
        '/landing': (context) => const Landing(),
        '/getStarted': (context) => Register(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        
        '/contacts': (context) => ContactsPage(
          registeredContacts: [],
          nonRegisteredContacts: [],
          onContactTap: (contact) {},
          onInviteContact: (contact) {},
          isLoading: false,
        ),
        '/registerPhone': (context) => RegisterPhone(),
        '/loginPhone': (context) => LoginPhone(),
        '/profile': (context) => Profile(),
        '/settings': (context) => Settings(),
        '/ai': (context) => AI_Page(),
        '/about': (context) => About(),
      },
    );
  }
}