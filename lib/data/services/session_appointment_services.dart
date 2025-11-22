import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/session_appointement_model.dart';

class SessionAppointmentServices {
  Future<String> addAppointment(String type, String date, int seesionId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}appointments/$seesionId'));
    request.fields.addAll({'type': type, 'date': date});

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

  Future<String> deleteAppointment(
      int idAppointment, String date, String type) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request(
        'DELETE', Uri.parse('${myUrl}appointments/$idAppointment'));
    request.bodyFields = {'type': type, 'date': date};
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

  Future<String> updateAppointment(
      int idAppointment, String date, String type) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.Request('PUT', Uri.parse('${myUrl}appointments/$idAppointment'));
    request.bodyFields = {'type': type, 'date': date};
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

  Future<SessionAppointementModel> getAppointment(int idAppointement) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var request = http.MultipartRequest(
        'GET', Uri.parse('${myUrl}appointments/$idAppointement'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return SessionAppointementModel.fromJson(
          jsonResponse['data'],
        );
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'failed: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<List> getAllAppointmentsBySessionId(int idSession) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request(
        'GET', Uri.parse('${myUrl}appointments/session/$idSession'));
    request.bodyFields = {};
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
}
