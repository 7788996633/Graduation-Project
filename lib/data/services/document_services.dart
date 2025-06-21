import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/document_model.dart';

class DocumentServices {
  Future<String> addDocument(
      File file,
      String privacy,
       int sessionId
      ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${myUrl}sessions/$sessionId/documents'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.fields.addAll({
      'privacy': privacy,
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
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

  Future<DocumentModel> getDocumentById(int documentId,int sessionId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.MultipartRequest(
        'GET', Uri.parse('${myUrl}sessions/$sessionId/documents/$documentId'));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load lawyer');
    }
  }
}
