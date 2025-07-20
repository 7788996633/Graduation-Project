import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class ReportService {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };
  Future<Map<String, dynamic>> reportFinancial() async {
    var url = Uri.parse('${myUrl}report-salaries');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('POST', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }
    return _handleReportResponse(response, 'فشل إنشاء تقرير الرواتب');
  }


  Future<Map<String, dynamic>> reportInvoices() async {
    var url = Uri.parse('${myUrl}invoices-report');
    http.Response response;
    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.get(url, headers: baseHeaders);
    }
    return _handleReportResponse(response, 'فشل إنشاء تقرير الدفعات المالية');
  }


  Future<Map<String, dynamic>> reportHiring() async {
    var url = Uri.parse('${myUrl}hiring-report');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      response = await http.get(url, headers: baseHeaders);
    }
    return _handleReportResponse(
        response, 'فشل إنشاء تقرير الوظائف والمتقدمين');
  }


  Future<Map<String, dynamic>> _handleReportResponse(http.Response response,
      String failMessage) async {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('$failMessage: ${jsonResponse['message']}');
    }
  }
}
