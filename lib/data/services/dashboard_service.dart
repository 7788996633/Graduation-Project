import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class DashboardServices {
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  /// عدد القضايا المفتوحة
  Future<int> fetchOpenIssuesCount() async {
    final response = await http.get(
      Uri.parse('${myUrl}issues/open/count'),
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      print('Response error: ${response.body}');
      throw Exception('فشل في تحميل عدد القضايا المفتوحة');
    }
  }

  /// عدد العملاء
  Future<int> fetchClientCount() async {
    final response = await http.get(
      Uri.parse('${myUrl}clients/count'),
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      print('Response error: ${response.body}');
      throw Exception('فشل في تحميل عدد العملاء');
    }
  }

  /// عدد الجلسات في هذا الشهر
  Future<int> fetchThisMonthSessionCount() async {
    final response = await http.get(
      Uri.parse('${myUrl}sessions/this-month'),
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      print('Response error: ${response.body}');
      throw Exception('فشل في تحميل عدد الجلسات لهذا الشهر');
    }
  }
  Future<int> fetchTotalRevenues() async {
    final response = await http.get(
      Uri.parse('${myUrl}invoices/total-revenues'),
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      print('Response error: ${response.body}');
      throw Exception('فشل في تحميل عدد الجلسات لهذا الشهر');
    }
  }
}