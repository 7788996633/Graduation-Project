import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/case_type_percentages_model.dart';

class CaseTypeService {
  final headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List<CaseTypePercentage>> fetchCaseTypePercentages() async {
    final url = Uri.parse('${myUrl}issues/case-type-percentages');

    final response = await http.get(url, headers: headers);
    final jsonResponse = json.decode(response.body);

    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      List data = jsonResponse['data'];
      return data.map((item) => CaseTypePercentage.fromJson(item)).toList();
    } else {
      throw Exception('فشل في تحميل نسب أنواع القضايا');
    }
  }
}
