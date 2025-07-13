import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // <-- Required for kIsWeb

import '../../constant.dart';
import '../models/consultation_Request_model.dart';

class ConsultationRequestServices {
  Future<String> addConsultationRequest(String subject, String details) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.post(
        Uri.parse('${myUrl}consultation_requests'),
        headers: {...headers, 'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'subject': subject, 'details': details},
      );
    } else {
      var request = http.MultipartRequest('POST', Uri.parse('${myUrl}consultation_requests'));
      request.fields.addAll({'subject': subject, 'details': details});
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<ConsultationRequestModel> getConsultationRequest(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.get(
        Uri.parse('${myUrl}consultation_requests/$id'),
        headers: headers,
      );
    } else {
      var request = http.MultipartRequest('GET', Uri.parse('${myUrl}consultation_requests/$id'));
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return ConsultationRequestModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message'] ?? response.reasonPhrase}');
    }
  }

  Future<List> getAllConsultationRequest() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.get(Uri.parse('${myUrl}consultation_requests'), headers: headers);
    } else {
      var request = http.MultipartRequest('GET', Uri.parse('${myUrl}consultation_requests'));
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<String> updateConsultationRequest(String subject, int id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };

    final response = await http.put(
      Uri.parse('${myUrl}consultation_requests/$id'),
      headers: headers,
      body: {'subject': subject},
    );

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<String> updateConsultationRequestStatus(int id, String status) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };

    final response = await http.put(
      Uri.parse('${myUrl}consultation_requests/status/$id'),
      headers: headers,
      body: {'status': status},
    );

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }

  Future<String> deleteConsultationRequest(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    final response = await http.delete(
      Uri.parse('${myUrl}consultation_requests/$id'),
      headers: headers,
    );

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message'] ?? response.reasonPhrase}';
    }
  }
}
