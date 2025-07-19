import 'dart:convert';
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import '../../../constant.dart';
import '../../localnotification.dart';

class NotificationsServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
    'Content-Type': 'application/json',
  };

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('🔄 Background Message');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  /// تهيئة الإشعارات
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    if (!kIsWeb) {
      await LocalNotification.init();
      LocalNotification.ensureConnected();
    }

    final fcmToken = await _firebaseMessaging.getToken();
    print('📱 FCM Token: $fcmToken');

    if (fcmToken != null) {
      final result = await sendFcmTokenToServer(fcmToken);
      print('Send token result: $result');
    }

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Foreground message received:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Payload: ${message.data}');

      if (!kIsWeb) {
        LocalNotification.showNotification(
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: '',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📲 App opened via notification');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    });
  }

  /// إرسال توكن FCM إلى السيرفر
  Future<String> sendFcmTokenToServer(String fcmToken) async {
    final url = Uri.parse('${myUrl}save-fcm-token');//'${myUrl}issue-categories'

    final body = json.encode({'fcm_token': fcmToken});

    try {
      final response = await http.post(url, headers: headers, body: body);

      final jsonResponse = json.decode(response.body);
      print('Response from save-fcm-token: $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['message'] != null) {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
      }
    } catch (e) {
      print('Error sending FCM token: $e');
      return 'failed: $e';
    }
  }

  /// جلب كل الإشعارات (مقروءة وغير مقروءة)
  Future<List> getAllNotifications() async {
    final url = Uri.parse('${myUrl}notifications');
    try {
      final response = await http.get(url, headers: headers);
      final jsonResponse = json.decode(response.body);
      print('Notifications response: $jsonResponse');
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      return [];
    }
  }

  /// جلب الإشعارات الغير مقروءة فقط
  Future<List> getUnreadNotifications() async {
    final url = Uri.parse('${myUrl}notifications/unread');
    try {
      final response = await http.get(url, headers: headers);
      final jsonResponse = json.decode(response.body);
      print('Unread notifications response: $jsonResponse');
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching unread notifications: $e');
      return [];
    }
  }

  /// حذف إشعار
  Future<String> deleteNotification(String notificationId) async {
    final url = Uri.parse('${myUrl}notifications/$notificationId');

    try {
      final response = await http.delete(url, headers: headers);

      final jsonResponse = json.decode(response.body);
      print('Delete notification response: $jsonResponse');

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
      }
    } catch (e) {
      print('Error deleting notification: $e');
      return 'failed: $e';
    }
  }

  /// تعليم إشعار كمقروء
  Future<String> markNotificationRead(String notificationId) async {
    final url = Uri.parse('${myUrl}notifications/mark-one/$notificationId');
    try {
      final response = await http.post(url, headers: headers);
      final jsonResponse = json.decode(response.body);
      print('Mark notification read response: $jsonResponse');
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
      }
    } catch (e) {
      print('Error marking notification as read: $e');
      return 'failed: $e';
    }
  }

  /// تعليم كل الإشعارات كمقروءة
  Future<String> markAllNotificationRead() async {
    final url = Uri.parse('${myUrl}notifications/mark-all');
    try {
      final response = await http.post(url, headers: headers);
      final jsonResponse = json.decode(response.body);
      print('Mark all notifications read response: $jsonResponse');
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
      }
    } catch (e) {
      print('Error marking all notifications as read: $e');
      return 'failed: $e';
    }
  }
}
