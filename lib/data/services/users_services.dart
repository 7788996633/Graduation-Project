import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/user_model.dart';

class UsersServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<String> deleteUserById(int userId) async {
    var url = Uri.parse('${myUrl}users/delete/$userId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('DELETE', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('DELETE', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<List> getAllUsers() async {
    var url = Uri.parse('${myUrl}users');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<String> changeUserRole(int userId, String role) async {
    var url = Uri.parse('${myUrl}users/change-role/$userId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('PUT', url);
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = {'role_name': role};
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('PUT', url);
      request.headers.addAll(baseHeaders);
      request.fields['role_name'] = role;
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<String> getMyRole() async {
    var url = Uri.parse('${myUrl}getRole');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<UserModel> getUserById(int userId) async {
    var url = Uri.parse('${myUrl}users/$userId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return UserModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message'] ?? response.reasonPhrase}');
    }
  }
}
