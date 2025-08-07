import 'dart:convert';
import 'package:flutter/foundation.dart'; // لإحضار kIsWeb
import 'package:http/http.dart' as http;
import '../../../constant.dart';

class NotificationsServices {
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getAllNotifications() async {
    final url = Uri.parse('${myUrl}notifications');

    late http.Response response;

    if (kIsWeb) {
      response = await http.get(url, headers: headers);
    } else {
      final request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<String> deleteNotification(String notificationId) async {
    final url = Uri.parse('${myUrl}notifications/$notificationId');

    late http.Response response;

    if (kIsWeb) {
      response = await http.delete(url, headers: headers);
    } else {
      final request = http.Request('DELETE', url);
      request.headers.addAll(headers);
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<String> markNotificationRead(String notificationId) async {
    final url = Uri.parse('${myUrl}notifications/mark-one/$notificationId');

    late http.Response response;

    if (kIsWeb) {
      response = await http.post(url, headers: headers);
    } else {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<String> markAllNotificationRead() async {
    final url = Uri.parse('${myUrl}notifications/mark-all');

    late http.Response response;

    if (kIsWeb) {
      response = await http.post(url, headers: headers);
    } else {
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }
}
