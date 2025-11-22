import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class LawyerInIssuesServices {
  Future<List> getLawyerInIssuesServices(int issueId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.Request('GET', Uri.parse('${myUrl}issues/$issueId/lawyers'));

    request.headers.addAll(headers);
    var streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return jsonResponse['data'];
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
