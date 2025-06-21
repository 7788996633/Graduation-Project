import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class LawyerServices {
  Future<List> getAllLawyers() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${myUrl}lawyers'));

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

  Future<String> deleteLawyer(int lawyerId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    var request = http.MultipartRequest(
      'DELETE',
      Uri.parse('${myUrl}employees/$lawyerId'),
    );

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

  // Future<LawyerModel> getLawyerById(int lawyerId) async {
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $myToken',
  //   };

  //   var request =
  //       http.MultipartRequest('GET', Uri.parse('${myUrl}lawyers/$lawyerId'));
  //   request.headers.addAll(headers);

  //   var streamedResponse = await request.send();
  //   var response = await http.Response.fromStream(streamedResponse);
  //   var jsonResponse = json.decode(response.body);
  //   print(jsonResponse);

  //   if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
  //     return jsonResponse['data'];
  //   } else {
  //     throw Exception('Failed to load lawyer');
  //   }
  // }
}
