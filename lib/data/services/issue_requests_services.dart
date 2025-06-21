import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/issue_request_model.dart';

class IssueRequestsServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getIssueRequests() async {
    var url = Uri.parse('${myUrl}issue-requests');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(baseHeaders);
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

  Future<IssueRequestModel> getIssueRequestById(int issueRequestId) async {
    var url = Uri.parse('${myUrl}issue-requests/$issueRequestId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return IssueRequestModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> addIssueRequest(String title, String description) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${myUrl}issue-requests'),
    );

    request.fields.addAll({
      'title': title,
      'description': description,
    });

    request.headers.addAll(baseHeaders);

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

  Future<String> updateIssueRequest(
      String title, String description, int issueRequestId) async {
    var url = Uri.parse('${myUrl}issue-requests/$issueRequestId');
    var body = {
      'title': title,
      'description': description,
    };

    http.Response response;

    if (kIsWeb) {
      var request = http.Request('POST', url);
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = body;
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(body);
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

  Future<String> updateIssueRequestAsAnAdmin(
      String adminNote, String status, int issueRequestId) async {
    var url = Uri.parse('${myUrl}admin/issue-requests/$issueRequestId');

    var request = http.Request('POST', url);
    request.headers.addAll({
      ...baseHeaders,
      'Content-Type': 'application/x-www-form-urlencoded',
    });

    request.bodyFields = {
      'admin_note': adminNote,
      'status': status,
    };

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

  Future<String> deleteIssueRequest(int issueRequestId) async {
    var url = Uri.parse('${myUrl}issue-requests/$issueRequestId');
    var request = http.MultipartRequest('DELETE', url);
    request.headers.addAll(baseHeaders);

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
