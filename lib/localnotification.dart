import 'dart:io';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'constant.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Socket? _socket;
  // تهيئة الإشعارات
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          print('Notification clicked: ${details.payload}');
          // يمكن التنقل داخل التطبيق بناءً على الـ payload
        }
      },
    );
  }

  // إظهار إشعار
  static void showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'Socket Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      const NotificationDetails(android: androidDetails),
      payload: payload,
    );
  }

  static Future<void> ensureConnected() async {
    if (_socket == null) {
      _socket = await Socket.connect(ip, 4040);
      _socket!.listen(
        _handleResponse,
        onError: (e) {
          print("Socket error: $e");
          _socket = null;
        },
        onDone: () {
          print("Socket closed");
          _socket = null;
        },
      );
    }
  }

  // معالجة الرسائل المستقبلة من السيرفر
  static void _handleResponse(List<int> data) {
    final response = jsonDecode(utf8.decode(data));
    if (response['type'] == 'message') {
      showNotification(
        title: 'From ${response['from']}',
        body: response['content'],
        payload: 'chat:${response['from']}',
      );
    }
  }
}
