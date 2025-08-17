import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../constant.dart';
import '../models/delegations_model.dart';

class DelegationServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getDelegations() async {
    try {
      var url = Uri.parse('${myUrl}delegations');
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
      print('Error in getDelegations: $e');
      return [];
    }
  }

  Future<DelegationModel> getDelegationById(int delegationId) async {
    try {
      var url = Uri.parse('${myUrl}delegations/$delegationId');
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
        return DelegationModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getDelegationById: $e');
    }
  }

  Future<String> addSubmitDelegation({
    required File file,
    // required String delegationFileName,
    required int sessionId,
    required int originalLawyerId,
  }) async {
    try {
      final url = Uri.parse('${myUrl}delegations/submit/$sessionId');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);

      if (kIsWeb) {
        // final mimeType =
        //     lookupMimeType(delegationFileName) ?? 'application/octet-stream';
        // final mimeParts = mimeType.split('/');
        // request.files.add(
        //   http.MultipartFile.fromBytes(
        //     'delegation_file',
        //     file as Uint8List,
        //     filename: delegationFileName,
        //     contentType: MediaType(mimeParts[0], mimeParts[1]),
        //   ),
        // );
      } else {
        // request.files.add(
        //   await http.MultipartFile.fromPath(
        //     'delegation_file',
        //     (file as File).path,
        //     filename: delegationFileName,
        //   ),
        // );
      }
      request.files.add(
        await http.MultipartFile.fromPath('delegation_file', file.path),
      );
      // request.fields.addAll({
      //   'session_id': sessionId.toString(),
      //   'original_lawyer_id': originalLawyerId.toString(),
      // });

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
      return 'Error in addDelegation: $e';
    }
  }

  Future<String> addApproveDelegation({
    required int delegationId,
    required int delegateLawyerId,
    required String adminNote,
  }) async {
    try {
      final url = Uri.parse('${myUrl}delegations/$delegationId/approve');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);

      request.fields.addAll({
        'delegate_lawyer_id': delegateLawyerId.toString(),
        'admin_note': adminNote,
      });

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
      return 'Error in addApproveDelegation: $e';
    }
  }

  Future<String> addRejectDelegation({
    required int delegationId,
    required int sessionId,
    required int originalLawyerId,
    required String adminNote,
  }) async {
    try {
      final url = Uri.parse('${myUrl}delegations/$delegationId/reject');
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);

      request.fields.addAll({
        'session_id': sessionId.toString(),
        'original_lawyer_id': originalLawyerId.toString(),
        'admin_note': adminNote,
      });

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
      return 'Error in addRejectDelegation: $e';
    }
  }

  Future<String> updateDelegation({
    required int delegationId,
    required dynamic delegationFile,
    required String delegationFileName,
  }) async {
    try {
      var url = Uri.parse('${myUrl}delegations/$delegationId');
      var request = http.MultipartRequest('PUT', url);
      request.headers.addAll(baseHeaders);

      if (kIsWeb) {
        final mimeType =
            lookupMimeType(delegationFileName) ?? 'application/octet-stream';
        final mimeParts = mimeType.split('/');
        request.files.add(
          http.MultipartFile.fromBytes(
            'delegation_file',
            delegationFile as Uint8List,
            filename: delegationFileName,
            contentType: MediaType(mimeParts[0], mimeParts[1]),
          ),
        );
      } else {
        request.files.add(
          await http.MultipartFile.fromPath(
            'delegation_file',
            (delegationFile as File).path,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'] ?? 'File updated successfully';
      } else {
        return 'failed: ${jsonResponse['message'] ?? 'Unknown error'}';
      }
    } catch (e) {
      return 'Error in updateDelegation: $e';
    }
  }

  Future<String> deleteDelegation(int delegationId) async {
    try {
      var url = Uri.parse('${myUrl}delegations/$delegationId');
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
      return 'Error in deleteDelegation: $e';
    }
  }
}
