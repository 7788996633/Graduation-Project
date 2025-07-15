import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../constant.dart';
import '../models/employee_model.dart';

class EmployeeServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<String> createEmployee(
      int userId,
      int salary,
      String hireDate,
      String certificatePath,
      String type,
      ) async {
    print('--- Creating Employee ---');
    print('UserId: $userId');
    print('Salary: $salary');
    print('Hire Date: $hireDate');
    print('Type: $type');
    print('Certificate Path: $certificatePath');

    final certFile = File(certificatePath);
    if (!certFile.existsSync()) {
      return 'failed: Certificate file not found';
    }

    try {
      DateTime.parse(hireDate);
    } catch (e) {
      return 'failed: Invalid hire date format. Expected yyyy-MM-dd';
    }

    final validTypes = ['hr', 'accountant', 'lawyer'];
    if (!validTypes.contains(type)) {
      return 'failed: Invalid employee type';
    }

    var url = Uri.parse('${myUrl}employees/create/$userId');

    if (kIsWeb) {
      // على الويب لا يمكن استخدام MultipartFile من الملف، فقط نرسل الحقول بدون ملف أو تحتاج طريقة أخرى للرفع
      var request = http.Request('POST', url);
      request.headers.addAll(baseHeaders);
      request.bodyFields = {
        'salary': salary.toString(),
        'hire_date': hireDate,
        'type': type,
        // لا يمكن ارسال ملف مباشرة في الويب بنفس الطريقة، تحتاج رفع بطريقة مختلفة (مثلاً base64)
      };

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } else {
      // على الأجهزة العادية (Android, iOS)
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);
      request.fields.addAll({
        'salary': salary.toString(),
        'hire_date': hireDate,
        'type': type,
      });
      request.files.add(await http.MultipartFile.fromPath('certificate', certificatePath));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    }
  }

  Future<List> getEmployees() async {
    var url = Uri.parse('${myUrl}employees');
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

  Future<EmployeeModel> getEmployeeById(int employeeId) async {
    var url = Uri.parse('${myUrl}employees/$employeeId');
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
      return EmployeeModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> deleteEmployee(int employeeId) async {
    var url = Uri.parse('${myUrl}employees/$employeeId');

    if (kIsWeb) {
      var request = http.Request('DELETE', url);
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
    } else {
      var request = http.MultipartRequest('DELETE', url);
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
    }
  }

  Future<String> updateEmployee(int salary, String certificatePath, int employeeId) async {
    var url = Uri.parse('${myUrl}employees/$employeeId');

    if (kIsWeb) {
      var body = {
        'salary': salary.toString(),
        'certificate': certificatePath, // قد تحتاج تغيير لرفع ملف على الويب (مثلاً base64)
      };
      var request = http.Request('POST', url);
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = body;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } else {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);
      request.fields.addAll({
        'salary': salary.toString(),
      });
      if (certificatePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('certificate', certificatePath));
      }
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
  }
}
