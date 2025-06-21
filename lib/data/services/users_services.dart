import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constant.dart';

class UsersServices {
  Future<String> deleteUserById(int userId) async {
    var url = Uri.parse('${myUrl}users/delete/$userId');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    // نستخدم http.delete بدلاً من MultipartRequest للحذف
    var response = await http.delete(url, headers: headers);

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } else {
      return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }

  Future<List> getAllUsers() async {
    var url = Uri.parse('${myUrl}users');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    // نستخدم http.get بدلاً من MultipartRequest للتحميل
    var response = await http.get(url, headers: headers);

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<String> changeUserRole(int userId, String role) async {
    var url = Uri.parse('${myUrl}users/change-role/$userId');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    // نستخدم http.put بدلاً من http.Request مع send
    var response = await http.put(url, headers: headers, body: {'role_name': role});

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } else {
      return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }

  Future<String> getMyRole() async {
    var url = Uri.parse('${myUrl}getRole');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    // نستخدم http.get بدلاً من MultipartRequest
    var response = await http.get(url, headers: headers);

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } else {
      return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }
}
