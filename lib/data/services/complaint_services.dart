import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/complaint_model.dart';

class ComplaintServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };


  Future<List> getComplaints() async {
    try {
      var url = Uri.parse('${myUrl}complaints');
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
      print('Error in getSessionTypes: $e');
      return [];
    }
  }


  Future<List> getMyComplaints()async {
    try {
      var url = Uri.parse('${myUrl}complaints/my/complaints');
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
      print('Error in getSessionTypes: $e');
      return [];
    }
  }




  // Get complaint by ID
  Future<ComplaintModel> getComplaintById(int complaintId) async {
    try {
      var url = Uri.parse('${myUrl}complaints/$complaintId');
      http.Response response;

      if (kIsWeb) {
        var request = http.Request('GET', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        var request = http.Request('GET', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      }

      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return ComplaintModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getComplaintById: $e');
    }
  }

  // Add complaint
  Future<String> addComplaint(String description) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${myUrl}complaints'),
      );

      request.fields.addAll({'description': description});
      request.headers.addAll(baseHeaders);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'Failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in addComplaint: $e';
    }
  }

  // Update complaint
  Future<String> updateComplaint(int complaintId, String description) async {
    try {
      var url = Uri.parse('${myUrl}complaints/$complaintId');
      var body = {'description': description};
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
        var request = http.MultipartRequest('PUT', url);
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
        return 'Failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in updateComplaint: $e';
    }
  }

  // Update complaint status
  Future<String> updateComplaintStatus(int complaintId, String status) async {
    try {
      var url = Uri.parse('${myUrl}complaints/$complaintId');
      var body = {'status': status};
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
        var request = http.MultipartRequest('PUT', url);
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
        return 'Failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in updateComplaintStatus: $e';
    }
  }

  // Delete complaint
  Future<String> deleteComplaint(int complaintId) async {
    try {
      var url = Uri.parse('${myUrl}complaints/$complaintId');
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
        return 'Failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in deleteComplaint: $e';
    }
  }
}
