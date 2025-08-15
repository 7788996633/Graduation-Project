import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/company_info_model.dart';

class CompanyInfoServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };


  Future<CompanyInfoModel> getCompany() async {
    var url = Uri.parse('${myUrl}company-info');
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
      return CompanyInfoModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to fetch company: ${jsonResponse['message']}');
    }
  }

  Future<String> updateCompany(
      String name,
      String address,
      String description,
      String goals,
      String vision,
      DateTime foundationDate, // أضف هذا
      ) async {
    try {
      var url = Uri.parse('${myUrl}company-info');


      String formattedDate = '${foundationDate.year}-${foundationDate.month
          .toString().padLeft(2, '0')}-${foundationDate.day.toString().padLeft(
          2, '0')}';

      var body = {
        'name': name,
        'address': address,
        'description': description,
        'goals': goals,
        'vision': vision,
        'foundation_date': formattedDate,
      };

      http.Response response;

      if (kIsWeb) {
        var request = http.Request('PUT', url);
        request.headers.addAll({
          ...baseHeaders,
          'Content-Type': 'application/x-www-form-urlencoded',
        });
        request.bodyFields = body;
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        var request = http.MultipartRequest('POST', url);
        request.fields.addAll(body);
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
    } catch (e) {
      return 'Error in updateCompany: $e';
    }
  }
}