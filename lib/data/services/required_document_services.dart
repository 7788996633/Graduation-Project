import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../constant.dart';
import '../models/required_document_model.dart';

class RequiredDocumentServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getRequiredDocuments() async {
    var url = Uri.parse('${myUrl}required-documents/');
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

  Future<RequiredDocumentModel> getRequiredDocumentById(
      int requiredDocumentId) async {
    var url = Uri.parse('${myUrl}required-documents/$requiredDocumentId');
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
      return RequiredDocumentModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<RequiredDocumentModel> getMyRequiredDocUp(int issueId) async {
    var url = Uri.parse('${myUrl}required-documents/$issueId');
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
      return RequiredDocumentModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> addRequiredDocument(
    int issueId,
    String requireFileType,
    String note,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${myUrl}required-documents/$issueId'),
    );

    request.fields.addAll({
      'require_file_type': requireFileType,
      'note': note,
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

  Future<String> updateRequiredDocument(
      int issueId, String status, String note) async {
    var url = Uri.parse('${myUrl}required-documents/$issueId');

    var request = http.Request('POST', url);
    request.headers.addAll({
      ...baseHeaders,
      'Content-Type': 'application/x-www-form-urlencoded',
    });

    request.bodyFields = {
      'status': status,
      'note': note,
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

  Future<String> deleteRequiredDocument(int requiredDocumentId) async {
    try {
      var url = Uri.parse('${myUrl}required-documents/$requiredDocumentId');
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
    } catch (e) {
      return 'Error in deleteSessionType: $e';
    }
  }

  Future<String> uploadRequiredDocument(int issueId, String filePath) async {
    var url = Uri.parse('${myUrl}required-documents/$issueId/upload');

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(baseHeaders);

    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        filePath,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      return 'Upload successful';
    } else {
      throw Exception('Failed to upload document');
    }
  }
}
