import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class AiChatServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
  };
  Future askAi(String ques) async {
    if (kIsWeb) {
      var url = Uri.parse('${myUrl}ask-ai');
      var body = {"question": ques};

      var request = http.Request('POST', url);
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = body;

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
    } else {
      var request = http.MultipartRequest('POST', Uri.parse('${myUrl}ask-ai'));
      request.fields.addAll({"question": ques});

      request.headers.addAll(baseHeaders);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true) {
          return jsonResponse['answer'];
        } else {
          return 'failed: please try again later... ';
        }
      } else {
        return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
      }
    }
  }
}
