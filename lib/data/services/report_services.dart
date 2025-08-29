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
    return _sendRequest(
      method: 'POST',
      endpoint: 'report-salaries',
      failMessage: 'فشل إنشاء تقرير الرواتب',
    );
  }

  Future<Map<String, dynamic>> reportInvoices() async {
    return _sendRequest(
      method: 'GET',
      endpoint: 'invoices-report',
      failMessage: 'فشل إنشاء تقرير الدفعات المالية',
    );
  }

  Future<Map<String, dynamic>> reportHiring() async {
    return _sendRequest(
      method: 'GET',
      endpoint: 'hiring-report',
      failMessage: 'فشل إنشاء تقرير الوظائف والمتقدمين',
    );
  }

  Future<Map<String, dynamic>> reportSession(int sessionId) async {
    return _sendRequest(
      method: 'GET',
      endpoint: 'session-report-pdf/$sessionId',
      failMessage: 'فشل إنشاء تقرير الجلسة',
    );
  }

  Future<Map<String, dynamic>> reportSalaries() async {
    return _sendRequest(
      method: 'POST',
      endpoint: 'report-salaries',
      failMessage: 'فشل إنشاء تقرير الدفعات المالية',
    );
  }

  Future<Map<String, dynamic>> reportUser(int userId) async {
    return _sendRequest(
      method: 'GET',
      endpoint: 'user-report/$userId',
      failMessage: 'فشل إنشاء تقرير المستخدم',
    );
  }

  Future<Map<String, dynamic>> reportIssue(int issueId) async {
    return _sendRequest(
      method: 'GET',
      endpoint: 'user-report/$issueId',
      failMessage: 'فشل إنشاء تقرير المستخدم',
    );
  }

  Future<Map<String, dynamic>> reportLawyer() async {
    return _sendRequest(
      method: 'POST',
      endpoint: 'lawyer/report',
      failMessage: 'فشل إنشاء تقرير المحامي ',
    );
  }
  Future<Map<String, dynamic>> _sendRequest({
    required String method,
    required String endpoint,
    required String failMessage,
  }) async {
    try {
      var url = Uri.parse('$myUrl$endpoint');
      http.Response response;

      if (kIsWeb) {
        // للويب استخدم http.Request لجميع أنواع الطلبات
        var request = http.Request(method, url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // للمنصات الأخرى نستخدم http.Client وطلب مناسب
        if (method.toUpperCase() == 'GET') {
          response = await http.get(url, headers: baseHeaders);
        } else if (method.toUpperCase() == 'POST') {
          response = await http.post(url, headers: baseHeaders);
        } else {
          // يمكنك توسيع لتغطية طرق أخرى إذا لزم الأمر
          throw Exception('Method $method not supported');
        }
      }

      return _handleReportResponse(response, failMessage);
    } catch (e) {
      throw Exception('Error in $_sendRequest: $e');
    }
  }

  Future<Map<String, dynamic>> _handleReportResponse(http.Response response, String failMessage) async {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('$failMessage: ${jsonResponse['message']}');
    }
  }
}
