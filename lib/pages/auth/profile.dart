import 'package:flutter/material.dart';
import 'package:ConnectUs/services/session_manager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _sessionManager = SessionManager();

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Logout', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Do you want to sign out?\n\n• Keep "Remember me": Quick login next time\n• Clear "Remember me": Full logout',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout(clearRememberMe: false);
              },
              child: const Text('Keep Remember Me', style: TextStyle(color: Colors.yellow)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _logout(clearRememberMe: true);
              },
              child: const Text('Full Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _logout({required bool clearRememberMe}) async {
    try {
      await _sessionManager.signOut(clearRememberMe: clearRememberMe);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(clearRememberMe ? 'Logged out completely' : 'Logged out (Remember me kept)'),
            backgroundColor: clearRememberMe ? Colors.red : Colors.orange,
          ),
        );
        Navigator.of(context).pushNamedAndRemoveUntil('/landing', (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
                'Wassup ??',
                style: TextStyle(color: Colors.white, fontSize: 24, decoration: TextDecoration.none),
              ),
        centerTitle: true,
        
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    body: Container(
      decoration: const BoxDecoration(
        color: Colors.yellow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
         
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.topCenter,
       child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
            
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.png')
              ),
              const SizedBox(height: 30),
              
              // User Info Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'User Profile',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _sessionManager.currentUser?.email ?? 'No email',
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Session Settings
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Session Settings',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    FutureBuilder<bool>(
                      future: _sessionManager.getRememberMe(),
                      builder: (context, snapshot) {
                        final rememberMe = snapshot.data ?? false;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Remember Me:', style: TextStyle(color: Colors.white70)),
                            Text(
                              rememberMe ? 'Enabled ✅' : 'Disabled ❌',
                              style: TextStyle(
                                color: rememberMe ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showLogoutDialog,
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text('Sign Out', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      )
      )
      )
    )
    );
  }
}