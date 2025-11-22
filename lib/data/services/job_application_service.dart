import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../constant.dart';
import '../models/job_application_model.dart';


class JobApplicationServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getJobApplications(int hiringReq) async {
    try {
      var url = Uri.parse('${myUrl}job-applications/by-hiring/$hiringReq');
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
      print('Error in getJobApplications: $e');
      return [];
    }
  }
  Future<List> getMyJobApplications() async {
    try {
      var url = Uri.parse('${myUrl}job-applications/');
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
      print('Error in getJobApplications: $e');
      return [];
    }
  }
  Future<JobApplicationModel> getJobApplicationById(int jobApplicationId) async {
    try {
      var url = Uri.parse('${myUrl}job-applications/$jobApplicationId'); // عدّل المسار إذا لزم
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
        return JobApplicationModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getJobApplicationById: $e');
    }
  }

  Future<String> addJobApplication(int hiringReqId, File cv) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${myUrl}job-applications/$hiringReqId'),
      );


      request.files.add(
        await http.MultipartFile.fromPath(
          'cv',
          cv.path,
          contentType: MediaType('application', 'pdf'),
        ),
      );

      request.headers.addAll(baseHeaders);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in addJobApplication: $e';
    }
  }


  Future<String> updateJobApplication(int jobApplicationId, String status) async {
    try {
      var url = Uri.parse('${myUrl}job-applications/update-status/$jobApplicationId');
      var body = {
        'status': status,
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
        var request = http.MultipartRequest('POST', url); // إذا API يقبل POST لتحديث
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
      return 'Error in updateJobApplication: $e';
    }
  }


}
