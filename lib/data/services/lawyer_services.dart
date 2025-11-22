import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../../constant.dart';

class LawyerServices {
  Future<List> getAllLawyers() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    if (kIsWeb) {

      var response = await http.get(
        Uri.parse('${myUrl}lawyers'),
        headers: headers,
      );
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    } else {

      var request = http.MultipartRequest(
        'GET',
        Uri.parse('${myUrl}lawyers'),
      );
      request.headers.addAll(headers);
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    }
  }

  Future<String> deleteLawyer(int lawyerId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    if (kIsWeb) {

      var response = await http.delete(
        Uri.parse('${myUrl}employees/$lawyerId'),
        headers: headers,
      );
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } else {

      var request = http.MultipartRequest(
        'DELETE',
        Uri.parse('${myUrl}employees/$lawyerId'),
      );
      request.headers.addAll(headers);
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    }
  }
}
