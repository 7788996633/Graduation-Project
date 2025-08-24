import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../constant.dart';
import '../models/legal_book_model.dart';

class LegalBookServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  /// إضافة كتاب قانوني
  Future<String> addLegalBook(dynamic file, String bookTitle, String fileName) async {
    try {
      var url = Uri.parse('${myUrl}legal-books');
      http.MultipartRequest request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);

      if (kIsWeb) {
        final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
        final mimeParts = mimeType.split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'book',
            file as Uint8List,
            filename: fileName,
            contentType: MediaType(mimeParts[0], mimeParts[1]),
          ),
        );
      } else {
        request.files.add(await http.MultipartFile.fromPath('book', (file as File).path));
      }

      request.fields['bookTitle'] = bookTitle;

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
      return 'Error in addLegalBook: $e';
    }
  }

  Future<String> saveLegalBook(int bookId) async {
    try {

      var url = Uri.parse('${myUrl}legal-books/$bookId/save');
      var request = http.MultipartRequest('POST', url);

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
      return 'Error in saveLegalBook: $e';
    }
  }
  /// جلب كتاب قانوني واحد
  Future<LegalBookModel> getLegalBookById(int bookId) async {
    try {
      var url = Uri.parse('${myUrl}legal-books/$bookId');
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
        return LegalBookModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getLegalBookById: $e');
    }
  }

  /// جلب كل الكتب القانونية
  Future<List> getAllLegalBooks() async {
    try {
      var url = Uri.parse('${myUrl}legal-books');
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
    } catch (e) {
      print('Error in getAllLegalBooks: $e');
      return [];
    }
  }

  Future<List> getMySavedLegalBooks() async {
    try {
      var url = Uri.parse('${myUrl}legalbooks/saved');
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
    } catch (e) {
      print('Error in getAllLegalBooks: $e');
      return [];
    }}

  Future<List> getMySaveLegalBooks() async {
    try {
      var url = Uri.parse('${myUrl}legalbooks/saved');
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
    } catch (e) {
      print('Error in getMySavedLegalBooks: $e');
      return [];
    }
  }

  /// تعديل كتاب قانوني
  Future<String> updateLegalBook({
    required int bookId,
    required String bookTitle,
    required String fileName,
    dynamic file, // يمكن أن يكون null إذا لم يتغير الملف
  }) async {
    try {
      var url = Uri.parse('${myUrl}legal-books/$bookId');
      http.MultipartRequest request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);
      request.fields['bookTitle'] = bookTitle;

      if (file != null) {
        if (kIsWeb) {
          final mimeType = lookupMimeType(fileName) ?? 'application/octet-stream';
          final mimeParts = mimeType.split('/');
          request.files.add(
            http.MultipartFile.fromBytes(
              'book',
              file as Uint8List,
              filename: fileName,
              contentType: MediaType(mimeParts[0], mimeParts[1]),
            ),
          );
        } else {
          request.files.add(await http.MultipartFile.fromPath('book', (file as File).path));
        }
      }

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
      return 'Error in updateLegalBook: $e';
    }
  }

  /// حذف كتاب قانوني
  Future<String> deleteLegalBook(int bookId) async {
    try {
      var url = Uri.parse('${myUrl}legal-books/$bookId');
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
    } catch (e) {
      return 'Error in deleteLegalBook: $e';
    }
  }

  Future<String> unSaveLegalBook(int bookId) async {
    try {
      var url = Uri.parse('${myUrl}legal-books/$bookId/unsave');
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
    } catch (e) {
      return 'Error in unSaveLegalBook: $e';
    }
  }


}
