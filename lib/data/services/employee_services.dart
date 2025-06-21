import 'dart:convert';

import '../../../constant.dart';
import 'package:http/http.dart' as http;

class EmployeeServices {
  Future addEmployee(
      int id, String salary, String certificatePath, String type) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${myUrl}employees/create/$id'));
    request.fields.addAll({
      'salary': salary,
      'hire_date': '2024-2-20',
      'certificate': certificatePath,
      'type': type
    });

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } else {
      return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }
}
