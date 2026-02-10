import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Your App Imports
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:ConnectUs/pages/chat/contact_selection_page.dart';
import 'package:ConnectUs/pages/home/home_page.dart';
import 'package:ConnectUs/pages/home/status.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  // Platform Checks
  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  bool get isDesktop =>
      kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux;

  int _selectedSection = 0;
  late PageController _pageController;

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addObserver(this); // Observe App Lifecycle
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
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
          content: const Text(
              'Camera functionality is only available on mobile devices.'),
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
    final List<Widget> pages = [
      const Home_Page(),
      const Status(),
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
                child: const Text('Settings',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              PopupMenuItem(
                value: 'logout',
                child:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  try {
                    await Supabase.instance.client.auth.signOut();
                    if (mounted) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Logout failed: $e'),
                          backgroundColor: Colors.red),
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
        children: pages,
      ),
    );
  }
}
