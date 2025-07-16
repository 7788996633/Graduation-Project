import 'dart:convert';
 import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/permission_model.dart';

class PermissionServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getPermissions() async {
    var url = Uri.parse('${myUrl}permissions');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.get(url, headers: baseHeaders);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<List> getPermissionsRole( int roleId) async {
    var url = Uri.parse('${myUrl}roles/$roleId/permissions');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.get(url, headers: baseHeaders);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<PermissionModel> getPermissionById(int userId) async {
    var url = Uri.parse('${myUrl}users/$userId/permissions');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.get(url, headers: baseHeaders);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return PermissionModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> addPermission(String name) async {
    var url = Uri.parse('${myUrl}permissions');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('POST', url);
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = {'name': name};
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({'name': name});
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message']}';
    }
  }

  Future<String> updatePermission(int permissionId, String name) async {
    var url = Uri.parse('${myUrl}permissions/$permissionId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('PUT', url);
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = {'name': name};
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('PUT', url);
      request.fields.addAll({'name': name});
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message']}';
    }
  }

  Future<String> deletePermission(int permissionId) async {
    var url = Uri.parse('${myUrl}permissions/$permissionId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('DELETE', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.Request('DELETE', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message']}';
    }
  }
}
