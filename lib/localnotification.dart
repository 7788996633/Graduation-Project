import 'dart:io';
import 'dart:convert';
import 'constant.dart';
import 'package:graduation/data/services/notifications_services.dart';
import 'package:graduation/blocs/notification_bloc/notification_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  static Future<void> ensureConnected(NotificationBloc bloc) async {
    if (_socket == null) {
      _socket = await Socket.connect(ip, 8000);
      _socket!.listen(
        (data) => _handleResponse(data, bloc),
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
  static void _handleResponse(List<int> data, NotificationBloc bloc) async {
    try {
      final response = jsonDecode(utf8.decode(data));

      if (response['type'] == 'message') {
        final from = response['from'];
        final content = response['content'];
        final notificationId = response['notification_id'];

        // 1. إظهار إشعار محلي
        showNotification(
          title: 'From $from',
          body: content,
          payload: 'chat:$from',
        );

        // 2. تحديث Bloc (إذا أردت مثلًا إعادة تحميل القائمة)
        bloc.add(UnReadNotificationEvent());

        // 3. تعليم كمقروء مباشرة (اختياري)
        if (notificationId != null) {
          try {
            await NotificationsServices().markNotificationRead(notificationId);
          } catch (e) {
            print("فشل تعليم الإشعار كمقروء: $e");
          }
        }
      }
    } catch (e) {
      print("خطأ في معالجة رسالة السوكت: $e");
    }
  }
}
