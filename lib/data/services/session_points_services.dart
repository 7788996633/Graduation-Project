import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../constant.dart';

class SessionPointsServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };
  Future<List> getAllPointsByIssueId(int issueId) async {
    try {
      var url = Uri.parse('${myUrl}sessions/calculate/$issueId');
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
        return jsonResponse['data']['sessions'];
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in get points: $e');
    }
  }

  Future<String> evaluateLawyerPoints(
      int sessionId, int lawyerId, int points, String? notes) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    if (kIsWeb) {
      var url = Uri.parse(
          '${myUrl}admin/lawyer-points/evaluate/$sessionId/$lawyerId');
      var body = {
        'points': points.toString(),
        'notes': notes ?? '',
      };

      var request = http.Request('POST', url);
      request.headers.addAll({
        ...headers,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = body;

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
    } else {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              '${myUrl}admin/lawyer-points/evaluate/$sessionId/$lawyerId'));
      request.fields.addAll({
        'points': points.toString(),
        'notes': notes ?? '',
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
  }
}
