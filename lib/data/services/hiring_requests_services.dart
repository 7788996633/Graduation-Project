import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/hiring_request_model.dart';

class HiringRequestsServices {
  Future<String> creatHiringRequests(
    String jopTitle,
    String type,
    String description,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${myUrl}hiring-requests'));
    request.fields.addAll({
      'jopTitle': jopTitle,
      'type': type,
      'description': description,
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

  Future<List> getHiringRequests() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.MultipartRequest('GET', Uri.parse('${myUrl}hiring-requests'));
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
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

  Future<HiringRequestModel> getHiringRequestById(int hiringRequestId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.MultipartRequest(
        'GET', Uri.parse('${myUrl}hiring-requests/show/$hiringRequestId'));
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
