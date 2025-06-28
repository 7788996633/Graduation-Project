import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../constant.dart';
import '../models/document_model.dart';

class DocumentServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  /// إضافة مستند
  Future<String> addDocument(dynamic file, String privacy, int sessionId, String fileName) async {
    final url = Uri.parse('${myUrl}sessions/$sessionId/documents');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(baseHeaders);

    if (kIsWeb) {
      final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
      final mimeParts = mimeType.split('/');
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          file as Uint8List,
          filename: fileName,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        ),
      );
    } else {
      request.files.add(await http.MultipartFile.fromPath('file', (file as File).path));
    }

    request.fields['privacy'] = privacy;

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

  /// جلب مستند واحد
  Future<DocumentModel> getDocumentById(int documentId, int sessionId) async {
    final url = Uri.parse('${myUrl}sessions/$sessionId/documents/$documentId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url)..headers.addAll(baseHeaders);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      response = await http.get(url, headers: baseHeaders);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return DocumentModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to load document');
    }
  }

  /// جلب كل المستندات
  Future<List<DocumentModel>> getAllDocuments() async {
    final url = Uri.parse('${myUrl}documents'); // عدّل الرابط حسب الـ API
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url)..headers.addAll(baseHeaders);
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
      List data = jsonResponse['data'];
      return data.map((e) => DocumentModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  /// تعديل مستند
  Future<String> updateDocument({
    required int documentId,
    required String privacy,
    required String fileName,
    dynamic file, // يمكن أن يكون null إذا لم يتغير الملف
  }) async {
    final url = Uri.parse('${myUrl}documents/$documentId');
    http.MultipartRequest request = http.MultipartRequest('POST', url)
      ..fields['privacy'] = privacy
      ..headers.addAll(baseHeaders);

    if (file != null) {
      if (kIsWeb) {
        final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
        final mimeParts = mimeType.split('/');
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          file as Uint8List,
          filename: fileName,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        ));
      } else {
        request.files.add(await http.MultipartFile.fromPath('file', (file as File).path));
      }
    }

    var streamed = await request.send();
    var response = await http.Response.fromStream(streamed);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message']}';
    }
  }

  /// حذف مستند
  Future<String> deleteDocument(int documentId) async {
    final url = Uri.parse('${myUrl}documents/$documentId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('DELETE', url)..headers.addAll(baseHeaders);
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
      return 'failed: ${jsonResponse['message']}';
    }
  }
}
