import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class DashServices {
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<int> getMonthlyCosts() async {
    final response = await http.get(
      Uri.parse('${myUrl}payrolls'),
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


  Future<int> getMonthlyRevenues() async {
    final response = await http.get(
      Uri.parse('${myUrl}invoices/reports/monthly-revenues'),
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
