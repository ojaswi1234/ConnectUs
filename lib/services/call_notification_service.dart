import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class CallNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize({
    required Function(String) onAccept,
    required Function(String) onDecline,
  }) async {
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings = 
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          if (details.actionId == 'accept_call') {
            onAccept(details.payload!);
          } else if (details.actionId == 'decline_call') {
            onDecline(details.payload!);
          } else {
            // Tap on body
            onAccept(details.payload!);
          }
        }
      },
    );

    // Create high-priority incoming call channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'call_channel_id',
      'Incoming Calls',
      description: 'High priority incoming call notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000, 500, 1000]),
      fullScreenIntent: true,
      priority: Priority.max,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> showIncomingCall({
    required String callerName,
    required String callType,
    required String roomId,
  }) async {
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'call_channel_id',
      'Incoming Calls',
      channelDescription: 'High priority incoming call notifications',
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
      category: AndroidNotificationCategory.call,
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 1000, 500, 1000, 500, 1000]),
      ongoing: true,
      autoCancel: false,
      visibility: NotificationVisibility.public,
      actions: [
        const AndroidNotificationAction(
          'accept_call',
          'Accept',
          showsUserInterface: true,
        ),
        const AndroidNotificationAction(
          'decline_call',
          'Decline',
          showsUserInterface: true,
        ),
      ],
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.timeSensitive,
    );

    final NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      999, // Fixed ID so we can cancel it later
      'Incoming ${callType == 'video' ? 'Video' : 'Voice'} Call',
      callerName,
      details,
      payload: '$callType|$callerName|$roomId',
    );
  }

  static Future<void> cancelCallNotification() async {
    await _notifications.cancel(999);
  }
}
