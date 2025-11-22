import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/invoice_model.dart';

class InvoiceServices {
  final Map<String, String> baseHeaders = {
    'Accept': 'application/json',
    'Authorization': 'Bearer $myToken',
  };

  Future<List> getInvoices() async {
    try {
      var url = Uri.parse('${myUrl}invoices');
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
      print('Error in getInvoices: $e');
      return [];
    }
  }

  Future<InvoiceModel> getInvoiceById(int invoiceId) async {
    try {
      var url = Uri.parse('${myUrl}invoices/show/$invoiceId');
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
        return InvoiceModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getInvoiceById: $e');
    }
  }

  Future<InvoiceModel> getInvoiceByUserId(int userId) async {
    try {
      var url = Uri.parse('${myUrl}invoices/user/$userId');
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
        return InvoiceModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } catch (e) {
      throw Exception('Error in getInvoiceById: $e');
    }
  }

  Future<List> getInvoicesByIssueId(int issueId) async {
    try {
      var url = Uri.parse('${myUrl}invoices/issue/$issueId');
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
      throw Exception('Error in getInvoiceById: $e');
    }
  }

  Future<String> addInvoice(
    int issueId,
    int userId,
    String status,
    int amount,
  ) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${myUrl}invoices/$issueId/$userId'),
      );

      request.fields.addAll({
        'status': status,
        'amount': amount.toString(),
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
      return 'Error in addInvoice: $e';
    }
  }

  Future<String> updateInvoice(int invoiceId, String status, int amount) async {
    try {
      var url = Uri.parse('${myUrl}invoices/$invoiceId');
      var body = {
        'status': 'paid',
        'amount': amount.toString(),
      };
      http.Response response;
      {
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
        return 'failed: ${jsonResponse['message']}';
      }
    } catch (e) {
      return 'Error in updateInvoice: $e';
    }
  }

  Future<String> deleteInvoice(int invoiceId) async {
    try {
      var url = Uri.parse('${myUrl}invoices/$invoiceId');

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
      return 'Error in deleteInvoice: $e';
    }
  }
}
