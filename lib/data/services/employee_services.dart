import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/employee_model.dart';

class EmployeeServices {
  Future<String> createEmployee(
      int userId,
      int salary,
      String hireDate,
      String certificate,
      String type,
      ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    var request =
    http.MultipartRequest('POST', Uri.parse('${myUrl}employees/create/$userId'));
    request.fields.addAll({
      'salary': salary.toString(),
      'hire_date': hireDate,
      'type': type,
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

  Future<List> getEmployees() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
    http.MultipartRequest('GET', Uri.parse('${myUrl}employees'));
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

  Future<EmployeeModel> getEmployeeById(int employeeId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.MultipartRequest(
        'GET', Uri.parse('${myUrl}employees/$employeeId'));
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return EmployeeModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to load Employee');
    }
  }

  Future<String> deleteEmployee(int employeeId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var request = http.MultipartRequest(
        'DELETE', Uri.parse('${myUrl}employees/$employeeId'));

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

  Future<String> updateEmployee(int salary,String certificate, int employeeId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}employees/$employeeId'));
    request.fields.addAll({'salary': salary.toString(),
      'certificate': certificate,
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
