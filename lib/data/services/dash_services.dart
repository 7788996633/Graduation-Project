import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class DashServices {
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List<dynamic>> fetchMonthlyCosts() async {
    final response = await http.get(
      Uri.parse('${myUrl}payrolls/getMonthlyCosts'),
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('فشل في تحميل التكاليف الشهرية');
    }
  }

  Future<List<dynamic>> fetchMonthlyRevenues() async {
    final response = await http.get(
      Uri.parse('${myUrl}invoices/reports/monthly-revenues'),
      headers: headers,
    );

    final jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('فشل في تحميل الإيرادات الشهرية');
    }
  }
}
