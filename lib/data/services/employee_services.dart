import 'dart:convert';
import 'dart:io';
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
    print('--- Creating Employee ---');
    print('UserId: $userId');
    print('Salary: $salary');
    print('Hire Date: $hireDate');
    print('Type: $type');
    print('Certificate Path: $certificate');

    // تحقق من وجود الملف
    final certFile = File(certificate);
    if (!certFile.existsSync()) {
      return 'failed: Certificate file not found';
    }

    // تحقق من صيغة التاريخ (yyyy-MM-dd)
    try {
      DateTime.parse(hireDate);
    } catch (e) {
      return 'failed: Invalid hire date format. Expected yyyy-MM-dd';
    }

    // تحقق من صحة نوع الموظف
    final validTypes = ['hr', 'accountant', 'lawyer'];
    if (!validTypes.contains(type)) {
      return 'failed: Invalid employee type';
    }

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${myUrl}employees/create/$userId'),
    );

    request.fields.addAll({
      'salary': salary.toString(),
      'hire_date': hireDate,
      'type': type,
      'certificate': certificate,
    });



    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
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
    var request = http.MultipartRequest('GET', Uri.parse('${myUrl}employees'));
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

    var request =
    http.MultipartRequest('GET', Uri.parse('${myUrl}employees/$employeeId'));
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

    var request =
    http.MultipartRequest('DELETE', Uri.parse('${myUrl}employees/$employeeId'));

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

  Future<String> updateEmployee(int salary, String certificate, int employeeId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}employees/$employeeId'));
    request.fields.addAll({
      'salary': salary.toString(),
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
