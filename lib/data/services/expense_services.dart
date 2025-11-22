import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/expenses_model.dart';

class ExpenseServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getExpenses() async {
    try {
      var url = Uri.parse('${myUrl}expenses');
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
    } catch (e) {
      print('Error in getExpenses: $e');
      return [];
    }
  }

  Future<ExpenseModel> getExpenseById(int expenseId) async {
    try {
      var url = Uri.parse('${myUrl}expenses/$expenseId');
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
        return ExpenseModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getExpenseById: $e');
    }
  }

  Future<String> addExpense(String description, double amount, String type) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('${myUrl}expenses'));
      request.fields.addAll({
        'description': description,
        'amount': amount.toString(),
        'type': type,
      });
      request.headers.addAll(baseHeaders);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
        return jsonResponse['message'];
      } else {
        return 'Failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in addExpense: $e';
    }
  }

  Future<String> updateExpense(int expenseId, String description, double amount) async {
    try {
      var url = Uri.parse('${myUrl}expenses/$expenseId');
      var body = {
        'description': description,
        'amount': amount.toString(),
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
        var request = http.MultipartRequest('PUT', url);
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
        return 'Failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in updateExpense: $e';
    }
  }

  Future<String> deleteExpense(int expenseId) async {
    try {
      var url = Uri.parse('${myUrl}expenses/$expenseId');
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
        return 'Failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in deleteExpense: $e';
    }
  }
}
