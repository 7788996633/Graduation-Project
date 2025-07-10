import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constant.dart';
import '../models/user_model.dart';

class UsersServices {
  Future<String> deleteUserById(int userId) async {
    var url = Uri.parse('${myUrl}users/delete/$userId');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

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

    var response = await http.put(
      url,
      headers: headers,
      body: {'role_name': role},
    );

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

  Future<UserModel> getUserById(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.MultipartRequest(
      'GET',
      Uri.parse('${myUrl}users/$userId'),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return UserModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to load User');
    }
  }
}
