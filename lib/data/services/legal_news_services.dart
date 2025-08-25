import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/legal_news_model.dart';

class LegalNewsServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<String> addLegalNews(String title, String description) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${myUrl}legal-news'),
      );

      request.fields.addAll({
        'title': title,
        'description': description,
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
      return 'Error in addLegalNews: $e';
    }
  }


  Future<LegalNewsModel> saveLegalNews(int legalNewsId)  async {
    var url = Uri.parse('${myUrl}legal-news/$legalNewsId/save');
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
      return LegalNewsModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> updateLegalNews(int newsId, String title, String description) async {
    try {
      var url = Uri.parse('${myUrl}legal-news/$newsId');
      var body = {
        'title': title,
        'description': description,
      };

      http.Response response;

      if (kIsWeb) {
        var request = http.Request('POST', url);
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
      return 'Error in updateLegalNews: $e';
    }
  }

  Future<List> getAllLegalNews() async {
    var url = Uri.parse('${myUrl}legal-news');
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
      return jsonResponse['data'];
    } else {
      return [];
    }
  }


  Future<LegalNewsModel> getLegalNewsById(int id) async {
    var url = Uri.parse('${myUrl}legal-news/$id');
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
      return LegalNewsModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }
  Future<String> deleteLegalNews(int legalNewsId) async {
    try {
      var url = Uri.parse('${myUrl}legal-news/$legalNewsId');

      http.Response response;

      if (kIsWeb) {
        var request = http.Request('DELETE', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        var request = http.Request('DELETE', url);
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
      return 'Error in deleteSessionType: $e';
    }
  }


  Future<List> mySavedLegalNews() async {
    var url = Uri.parse('${myUrl}legalNews/saved');
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
      return jsonResponse['data'];
    } else {
      return [];
    }
  }


  Future<List> getLateNews() async {
    var url = Uri.parse('${myUrl}legal-news/latest');
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
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<String> unSaveLegalNews(int legalNewsId) async {
    try {
      var url = Uri.parse('${myUrl}legal-news/$legalNewsId/unsave');

      http.Response response;

      if (kIsWeb) {
        var request = http.Request('DELETE', url);
        request.headers.addAll(baseHeaders);
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        var request = http.Request('DELETE', url);
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
      return 'Error in deleteSessionType: $e';
    }
  }


}
