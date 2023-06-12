import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "twoBeWedd", // id
    "twoBeWedd App Notifications", // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  Future<void> showNotification(RemoteNotification? notification) async {
    flutterLocalNotificationsPlugin.show(
      0,
      notification?.title,
      notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "twoBeWedd", // id
          "twoBeWedd App Notifications", // title
          icon: "@mipmap/ic_launcher",
          enableVibration: true,
          playSound: true,
          channelShowBadge: true,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true,
          presentBadge: true,
        ),
      ),
    );
  }

  void notificationsOnMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        notificationsInitialize(context);
      }
      showNotification(message.notification);
    });
  }

  void notificationsClick(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('onMessageOpenedApp');
    });
  }

  void notificationsClickTerminated(BuildContext context) async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        debugPrint('notificationsClickTerminated');
      }
    });
  }

  void notificationsInitialize(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) {});
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
