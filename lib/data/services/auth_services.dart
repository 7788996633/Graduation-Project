import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';

class AuthServices {
  // Login method
  Future<String> login(String email, String password) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest('POST', Uri.parse('${myUrl}login'));
    request.fields.addAll({'email': email, 'password': password});
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        final token = jsonResponse['data']['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return token;
      } else {
        return jsonResponse['message'];
      }
    } else {
      return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }

  // Register method
  Future<String> register(String name, String password, String email,
      String confirmPassword) async {
    var headers = {'Accept': 'application/json'};
    var request = http.MultipartRequest('POST', Uri.parse('${myUrl}register'));
    request.fields.addAll({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        final token = jsonResponse['data']['token'];

        // 📝 Save token to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return token;
      } else {
        return jsonResponse['message'];
      }
    } else {
      return 'failed: ${response.statusCode} - ${response.reasonPhrase}';
    }
  }
}
