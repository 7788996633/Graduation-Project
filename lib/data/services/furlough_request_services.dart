import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/furlough_request_model.dart';

class FurloughRequestsServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getFurloughRequests() async {
    var url = Uri.parse('${myUrl}furloughs');
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
  }

  Future<List> getMyFurloughRequests() async {
    var url = Uri.parse('${myUrl}furloughs/my/furlough');
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
  }

  Future<FurloughRequestModel> getFurloughRequestById(int furloughRequestId) async {
    var url = Uri.parse('${myUrl}furloughs/$furloughRequestId');
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
      return FurloughRequestModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> addFurloughRequest(String cause, String startDate, String endDate) async {
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('POST', Uri.parse('${myUrl}furloughs'));
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = {
        'cause': cause,
        'start_date': startDate,
        'end_date': endDate,
      };
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('POST', Uri.parse('${myUrl}furloughs'));
      request.fields.addAll({
        'cause': cause,
        'start_date': startDate,
        'end_date': endDate,
      });
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
  }

  Future<String> updateFurloughRequest(int furloughRequestId, String cause) async {
    var url = Uri.parse('${myUrl}furloughs/$furloughRequestId');
    var body = {
      'cause': cause,
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
      return 'failed: ${jsonResponse['message']}';
    }
  }

  Future<String> updateFurloughRequestStatus(int furloughRequestId, String status) async {
    var url = Uri.parse('${myUrl}furloughs/status/$furloughRequestId');

    var request = http.Request('PUT', url);
    request.headers.addAll({
      ...baseHeaders,
      'Content-Type': 'application/x-www-form-urlencoded',
    });

    request.bodyFields = {
      'status': status,
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

  Future<String> deleteFurloughRequest(int furloughRequestId) async {
    var url = Uri.parse('${myUrl}furloughs/$furloughRequestId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('DELETE', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('DELETE', url);
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
  }
}
