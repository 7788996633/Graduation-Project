import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/interview_model.dart';

class InterviewServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getInterviews(int jobAPPId) async {
    try {
      var url = Uri.parse('${myUrl}interviews/application/$jobAPPId');
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
      print('Error in getInterviews: $e');
      return [];
    }
  }

  Future<InterviewModel> getInterviewById(int interviewId) async {
    try {
      var url = Uri.parse('${myUrl}interviews/$interviewId');
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
        return InterviewModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getInterviewById: $e');
    }
  }

  Future<String> addInterview(int jobAppId,String date) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${myUrl}interviews/$jobAppId'),
      );
      request.fields.addAll({
        'date': date,

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
    } catch (e) {
      return 'Error in addInterview: $e';
    }
  }

  Future<String> updateInterview(int interviewId,String date) async {
    try {
      var url = Uri.parse('${myUrl}interviews/$interviewId');
      var body = {
        'date': date.toString(),
      };

      http.Response response;

      if (kIsWeb) {
        var request = http.Request('PUT', url);
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
    } catch (e) {
      return 'Error in updateInterview: $e';
    }
  }
  Future<String> updateInterviewResult(int interviewId,String result) async {
    try {
      var url = Uri.parse('${myUrl}interviews/$interviewId');
      var body = {
        'result': result,
      };

      http.Response response;

      if (kIsWeb) {
        var request = http.Request('PUT', url);
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
    } catch (e) {
      return 'Error in updateInterview: $e';
    }
  }

  Future<String> deleteInterview(int interviewId) async {
    try {
      var url = Uri.parse('${myUrl}interviews/$interviewId');

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
      return 'Error in deleteInterview: $e';
    }
  }
}
