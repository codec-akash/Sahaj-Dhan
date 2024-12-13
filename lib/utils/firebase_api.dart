import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    if (Platform.isAndroid) {
      await _firebaseMessaging.requestPermission();
      final String? fcmToken = await _firebaseMessaging.getToken();
      debugPrint("fcm token is -- $fcmToken");
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
      );
      try {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        print("channel set");
      } catch (e) {
        print("channel set error");
      }
      try {
        FirebaseMessaging.onMessage.distinct().listen((event) {
          if (event.contentAvailable) {
            debugPrint("payload - ${event.data}");
          }
        });
        // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      } catch (e) {}
    }
  }

  void listenFcmToken() {
    _firebaseMessaging.onTokenRefresh.listen((event) {
      print("updated token is $event");
    });
  }

  void listenFcmMessage() async {
    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;
      debugPrint("notification on FE handled");
      if (notification != null && android != null) {
        // Display the notification in the tray
        flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications',
              channelDescription:
                  'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {}
}
