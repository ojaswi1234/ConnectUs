import 'package:flutter/material.dart';
import 'package:ConnectUs/services/call_service.dart';
import 'package:ConnectUs/pages/chat/voice.dart';
import 'package:ConnectUs/pages/chat/video.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ConnectUs/providers/call_provider.dart';
import 'package:ConnectUs/services/call_notification_service.dart';

class IncomingCallScreen extends ConsumerWidget {
  final Map<String, dynamic> callData;

  const IncomingCallScreen({super.key, required this.callData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callerName = callData['caller'] ?? 'Unknown Caller';
    final callType = callData['callType'] ?? 'voice';

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 30),
            Text(
              callerName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Incoming ${callType == 'video' ? 'Video' : 'Voice'} Call...',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(
                  icon: Icons.call_end,
                  color: Colors.red,
                  onPressed: () async {
                    await CallNotificationService.cancelCallNotification();
                    ref.read(callServiceProvider).declineCall();
                    Navigator.pop(context);
                  },
                ),
                _buildButton(
                  icon: Icons.call,
                  color: Colors.green,
                  onPressed: () async {
                    await CallNotificationService.cancelCallNotification();
                    Navigator.pop(context); // Close incoming screen
                    final callService = ref.read(callServiceProvider);
                    await callService.acceptCall();
                    if (callType == 'video') {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Video(userName: callerName, callService: callService)));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Voice(userName: callerName, callService: callService)));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required IconData icon, required Color color, required VoidCallback onPressed}) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 35),
        onPressed: onPressed,
      ),
    );
  }
}
