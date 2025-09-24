import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:qalb/storage/secure_storage.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessagingService._internal();

  Future<void> init() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    await _getToken();

    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // When app is in background but opened via a notification
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // When app is terminated and opened via a notification
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }

    // Handle token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      // Optionally send token to your server
      print("FCM Token refreshed: $newToken");
    });
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> _getToken() async {
    String? token = await _messaging.getToken();

    final storage = SecureStorageHelper();
    var deviceId = await storage.getDeviceId();
    var authToken = await storage.getAuthToken();

    if (deviceId == null) return;
    final response = await http.post(
      Uri.parse('https://5j34gl7j-8000.inc1.devtunnels.ms/device'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': authToken ?? '',
      },
      body: jsonEncode({'firebaseToken': token, 'deviceId': deviceId}),
    );
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) {
        print("Notification clicked with payload: $payload");
        // Optional: Navigate based on payload
      },
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    print("Foreground message received: ${message.notification?.title}");

    if (message.notification != null) {
      _showLocalNotification(message);
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    print("Notification caused app to open: ${message.data}");

    // Handle navigation or other logic here
    if (message.data['route'] != null) {
      final String route = message.data['route'];
      // Use navigatorKey to navigate
      navigatorKey.currentState?.pushNamed(route);
    }
  }

  void _showLocalNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'channel_id',
          'Default Channel',
          importance: Importance.high,
          priority: Priority.high,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    _localNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: message.data['payload'] ?? '',
    );
  }
}
