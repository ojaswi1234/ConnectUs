import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ferry/ferry.dart';

// Your App Imports
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:ConnectUs/pages/chat/contactSelectionPage.dart';
import 'package:ConnectUs/pages/home/home_page.dart';
import 'package:ConnectUs/pages/home/status.dart';
import 'package:ConnectUs/pages/home/community.dart';

// GraphQL Imports (Required for listener)
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  // Platform Checks
  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get isDesktop => kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  int _selectedSection = 0;
  late PageController _pageController;
  
  // LOGIC: Variables for Realtime Updates
  StreamSubscription? _messageSubscription;
  String? _myUsername;
  Key _chatListKey = UniqueKey(); // Forces refresh

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addObserver(this); // Observe App Lifecycle
    _setupRealtimeListener(); // Start Listening
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _messageSubscription?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // LOGIC: Realtime Listener Implementation
  Future<void> _setupRealtimeListener() async {
    final client = Provider.of<Client>(context, listen: false);
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      // 1. Get my username
      final data = await Supabase.instance.client
          .from('users')
          .select('usrname')
          .eq('id', user.id)
          .maybeSingle();

      if (data != null) {
        _myUsername = data['usrname'];

        // 2. Subscribe to messages sent TO me
        final subReq = GOnMessageSentToUserReq((b) => b
          ..vars.user = _myUsername!
        );

        _messageSubscription = client.request(subReq).listen((response) {
          if (response.data?.messageSentToUser != null) {
            final msg = response.data!.messageSentToUser;
            
            // 3. Force UI Refresh when message arrives
            if (mounted) {
              setState(() {
                _chatListKey = UniqueKey(); // This rebuilds Home_Page
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("New message from ${msg.user}"),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        });
      }
    }
  }

  Future<void> _openingCamera() async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (!mounted) return;
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (_imageFile != null) Image.file(_imageFile!, height: 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('Retake'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _openingCamera();
                        },
                      ),
                      TextButton(
                        child: const Text('Use Photo'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ContactSelectionPage(imageFile: _imageFile!),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Camera Not Supported'),
          content: const Text('Camera functionality is only available on mobile devices.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // LOGIC: Define pages here so Home_Page gets the updated key
    final List<Widget> pages = [
      Home_Page(key: _chatListKey), // Pass key here
      const Status(),
      const Community(),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'ConnectUs',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.accentDark,
        elevation: 2,
        actions: [
          MaterialButton(
            minWidth: 52,
            height: 52,
            padding: const EdgeInsets.all(0),
            shape: const CircleBorder(),
            onPressed: _openingCamera,
            child: Icon(
              Icons.camera_alt_outlined,
              color: (isMobile) ? Colors.black : Colors.transparent,
            ),
          ),
          PopupMenuButton(
            color: AppTheme.surface,
            icon: const Icon(Icons.settings, color: Colors.black),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'new_group',
                child: Text('New Group', style: TextStyle(color: Colors.white)),
              ),
              PopupMenuItem(
                value: 'settings',
                child: const Text('Settings', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              PopupMenuItem(
                value: 'logout',
                child: const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  try {
                    await Supabase.instance.client.auth.signOut();
                    if (mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e'), backgroundColor: Colors.red),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.background,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: AppTheme.accentDark),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: AppTheme.accentDark),
            label: 'Status',
          ),
        ],
        currentIndex: _selectedSection,
        unselectedItemColor: AppTheme.accent,
        selectedItemColor: AppTheme.accentDark,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedSection = index;
          });
        },
        children: pages, // Use the local list
      ),
    );
  }
}