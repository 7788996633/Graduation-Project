import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/case_type_percentages_model.dart';

class CaseTypeService {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List<CaseTypePercentage>> fetchCaseTypePercentages() async {
    try {
      var url = Uri.parse('${myUrl}issues/case-type-percentages');
      http.Response response;

      if (kIsWeb) {
        // استخدام http.Request للويب
        var request = http.Request('GET', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // استخدام MultipartRequest للموبايل
        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      }

      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        List data = jsonResponse['data'];
        return data
            .map((item) => CaseTypePercentage.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error in fetchCaseTypePercentages: $e');
      return [];
    }
  }
}
