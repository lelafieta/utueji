import 'dart:async';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings(Platform.version.contains('29') ||
                Platform.version.contains('30') ||
                Platform.version.contains('31')
            ? 'ic_notification'
            : 'ic_notification_color');

    final InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(settings);
  }

  static Future<void> _showNotification({
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    required String soundName,
  }) async {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(channelId, channelName,
            importance: Importance.high,
            priority: Priority.high,
            icon: 'ic_notification',
            enableVibration: true
            // sound: RawResourceAndroidNotificationSound(soundName),
            );

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  static void sendNotification({String title = "title", String body = "body"}) {
    _showNotification(
      title: title,
      body: body,
      channelId: "high_importance_channel",
      channelName: "High Importance Notifications",
      soundName: "alert_rounda",
    );
  }

  static void sendNotificationSuccess({String? message}) {
    _showNotification(
      title: "Picagem Realizada",
      body: message ?? "Picagem realizada com sucesso",
      channelId: "alert_success_channel",
      channelName: "Alert Success",
      soundName: "alert_success",
    );
  }
}
