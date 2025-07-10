import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class DashboardServices {
  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  /// عدد القضايا المفتوحة
  Future<int> fetchOpenIssuesCount() async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse('${myUrl}issues/open/count'),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('فشل في تحميل عدد القضايا المفتوحة');
    }
  }

  /// عدد العملاء
  Future<int> fetchClientCount() async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse('${myUrl}clients/count'),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('فشل في تحميل عدد العملاء');
    }
  }

  /// عدد الجلسات في هذا الشهر
  Future<int> fetchThisMonthSessionCount() async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse('${myUrl}sessions/this-month'),
    );
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      throw Exception('فشل في تحميل عدد الجلسات لهذا الشهر');
    }
  }
}
