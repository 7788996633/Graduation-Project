import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/salary_adjustments_model.dart';

class SalaryAdjustmentServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };




  Future<Map<String, dynamic>?> getSalaryAdjustments(int userId) async {
    var url = Uri.parse('${myUrl}salary-adjustments/$userId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(baseHeaders);
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data']; // هنا نعيد Map وليس List
    } else {
      return null;
    }
  }



  Future<SalaryAdjustment> getSalaryAdjustmentById(int id) async {
    try {
      var url = Uri.parse('${myUrl}salary-adjustments/$id');
      http.Response response;

      if (kIsWeb) {
        var request = http.Request('GET', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        var request = http.MultipartRequest('GET', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      }

      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return SalaryAdjustment.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getSessionTypeById: $e');
    }
  }
  Future<String> addSalaryAdjustment(int  userId,String type,String reason ,String amount
      ,String effectiveDate) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${myUrl}salary-adjustments/$userId'),
      );

      request.fields.addAll({
        'user_id': userId.toString(),
        'type': type,
        'reason': reason,
        'amount':amount,
        'effective_date':effectiveDate,
      });

      request.headers.addAll(baseHeaders);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in addSalaryAdjustment: $e';
    }
  }
}
