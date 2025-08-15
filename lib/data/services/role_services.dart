import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class RoleServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<String> addRole(String name) async {
    var url = Uri.parse('${myUrl}roles');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('POST', url);
      request.headers.addAll({
        ...baseHeaders,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = {'name': name};
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({'name': name});
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message']}';
    }
  }
}
