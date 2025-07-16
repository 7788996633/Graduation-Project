import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/user_profile_model.dart';

class UserProfileServices {
  Future<UserProfileModel> showProfile() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}myprofile');
    var request = http.Request('GET', url)..headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return UserProfileModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message'] ?? response.reasonPhrase}');
    }
  }

  Future<UserProfileModel> showProfileById(int userId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}profile/$userId');
    var request = http.Request('GET', url)..headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return UserProfileModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message'] ?? response.reasonPhrase}');
    }
  }

  Future<String> updateProfile(
      String phone, String address, String age, String scientificLevel) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}profile/update');
    var body = {
      'phone': phone,
      'address': address,
      'age': age,
      'scientificLevel': scientificLevel,
    };

    var request = http.Request('POST', url)
      ..headers.addAll(headers)
      ..bodyFields = body;

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<String> createProfile(
      String phone, String address, String age, String scientificLevel, String imagePath) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}profiles/create');
    var request = http.MultipartRequest('POST', url)
      ..fields.addAll({
        'phone': phone,
        'address': address,
        'age': age,
        'scientificLevel': scientificLevel,
      })
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', imagePath));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<String> deleteProfile() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}profile');
    var request = http.Request('DELETE', url)..headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }
}
