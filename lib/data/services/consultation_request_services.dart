import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/cons_req_model.dart';

class ConsultationRequestServices {
  Future<String> addConsultationRequest(String subject, String details) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      // للويب
      response = await http.post(
        Uri.parse('${myUrl}consultation_requests'),
        headers: headers,
        body: {'subject': subject, 'details': details},
      );
    } else {
      // للموبايل
      var request = http.MultipartRequest(
          'POST', Uri.parse('${myUrl}consultation_requests'));
      request.fields.addAll({'subject': subject, 'details': details});
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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

  Future<ConsReqModel> getConsultationRequest(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.get(
        Uri.parse('${myUrl}consultation_requests/$id'),
        headers: headers,
      );
    } else {
      var request = http.MultipartRequest(
          'GET', Uri.parse('${myUrl}consultation_requests/$id'));
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return ConsReqModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'failed: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<List> getAllConsultationRequest() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.get(
        Uri.parse('${myUrl}consultation_requests'),
        headers: headers,
      );
    } else {
      var request =
      http.MultipartRequest('GET', Uri.parse('${myUrl}consultation_requests'));
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<List> getUserConsultationRequest() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.get(
        Uri.parse('${myUrl}consultation_requests/showMyRequests'),
        headers: headers,
      );
    } else {
      var request = http.MultipartRequest(
          'GET', Uri.parse('${myUrl}consultation_requests/showMyRequests'));
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future<String> updateConsultationRequest(String subject, int id) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.put(
        Uri.parse('${myUrl}consultation_requests/$id'),
        headers: headers,
        body: {'subject': subject},
      );
    } else {
      var request =
      http.Request('PUT', Uri.parse('${myUrl}consultation_requests/$id'));
      request.bodyFields = {'subject': subject};
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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

  Future<String> updateConsultationRequestStatus(int id, String status) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.put(
        Uri.parse('${myUrl}consultation_requests/status/$id'),
        headers: headers,
        body: {'status': status},
      );
    } else {
      var request = http.Request(
          'PUT', Uri.parse('${myUrl}consultation_requests/status/$id'));
      request.bodyFields = {'status': status};
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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

  Future<String> deleteConsultationRequest(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    http.Response response;

    if (kIsWeb) {
      response = await http.delete(
        Uri.parse('${myUrl}consultation_requests/$id'),
        headers: headers,
      );
    } else {
      var request =
      http.Request('DELETE', Uri.parse('${myUrl}consultation_requests/$id'));
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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
