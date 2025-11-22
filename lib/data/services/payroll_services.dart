import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/payroll_model.dart';

class PayrollServices {
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<PayrollModel> addPayroll(int userId) async {
    var url = Uri.parse('${myUrl}payrolls/$userId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('POST', url);
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.post(url, headers:headers);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return PayrollModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<PayrollModel> getPayrollById(int payrollId) async {
    final response = await http.get(
      Uri.parse('${myUrl}payrolls/$payrollId'),
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return PayrollModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('فشل في تحميل الراتب');
    }
  }


  Future<List> getPayrolls() async {
    var url = Uri.parse('${myUrl}payrolls');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.get(url, headers: headers);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

}
