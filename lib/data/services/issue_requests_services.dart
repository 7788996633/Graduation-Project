import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/issue_request_model.dart';

class IssueRequestsServices {
  Future<List> getIssueRequests() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request =
        http.MultipartRequest('GET', Uri.parse('${myUrl}issue-requests'));
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

  Future<IssueRequestModel> getIssueRequestById(int issueRequestId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.Request(
        'GET', Uri.parse('${myUrl}issue-requests/$issueRequestId'));
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return IssueRequestModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> addIssueRequest(String title, String description) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('${myUrl}issue-requests'));
    request.fields.addAll({
      'title': title,
      'description': description,
    });

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

  Future<String> updateIssueRequest(
      String title, String description, int issueRequestId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.Request(
        'POST', Uri.parse('${myUrl}issue-requests/$issueRequestId'));
    request.bodyFields = {
      'title': title,
      'description': description,
    };

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

  Future<String> updateIssueRequestAsAnAdmin(
      String adminNote, String status, int issueRequestId) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.Request(
        'POST', Uri.parse('${myUrl}admin/issue-requests/$issueRequestId'));
    request.bodyFields = {
      'admin_note': adminNote,
      'status': status,
    };

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

  Future<String> deleteIssueRequest(int issueRequestId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.MultipartRequest(
        'DELETE', Uri.parse('${myUrl}issue-requests/$issueRequestId'));
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
