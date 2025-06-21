import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../constant.dart';
import '../../../data/models/issues_model.dart';

class IssusServices {
  Future<String> issueCreateService(
    String title,
    String issueNumber,
    String category,
    String courtName,
    String status,
    String priority,
    String startDate,
    String endDate,
    String totalCost,
    int numberOfPayments,
    String opponentName,
    int userId,
    int amoountPaid,
    String description,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    if (kIsWeb) {
      var url = Uri.parse('${myUrl}issues/$userId');
      var body = {
        'title': title,
        'issue_number': issueNumber,
        'category': category,
        'court_name': courtName,
        'status': status,
        'priority': priority,
        'start_date': startDate,
        'end_date': endDate,
        'total_cost': totalCost,
        'number_of_payments': numberOfPayments.toString(),
        'opponent_name': opponentName,
        'amount_paid': amoountPaid.toString(),
        'description': description,
      };

      var request = http.Request('POST', url);
      request.headers.addAll({
        ...headers,
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
      var request =
          http.MultipartRequest('POST', Uri.parse('${myUrl}issues/$userId'));
      request.fields.addAll({
        'title': title,
        'issue_number': issueNumber,
        'category': category,
        'court_name': courtName,
        'status': status,
        'priority': priority,
        'start_date': startDate,
        'end_date': endDate,
        'total_cost': totalCost,
        'number_of_payments': numberOfPayments.toString(),
        'opponent_name': opponentName,
        'amount_paid': amoountPaid.toString(),
        'description': description
      });

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
  }

  Future<String> issueUpdateService(
    int id,
    String title,
    String issueNumber,
    String category,
    String courtName,
    String status,
    String priority,
    String startDate,
    String endDate,
    String totalCost,
    int numberOfPayments,
    String opponentName,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}issues/$id');

    var body = {
      'title': title,
      'issue_number': issueNumber,
      'category': category,
      'court_name': courtName,
      'status': status,
      'priority': priority,
      'start_date': startDate,
      'end_date': endDate,
      'total_cost': totalCost,
      'number_of_payments': numberOfPayments.toString(),
      'opponent_name': opponentName,
    };

    http.Response response;

    var request = http.Request('PUT', url);
    request.headers.addAll(headers);
    request.bodyFields = body;

    var streamedResponse = await request.send();
    response = await http.Response.fromStream(streamedResponse);

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

  Future<String> issuePriorityUpdateService(
    int id,
    String priority,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}issues/$id/priority');
    var body = {'priority': priority};

    if (kIsWeb) {
      var request = http.Request('POST', url);
      request.headers.addAll(headers);
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
      var request = http.MultipartRequest('POST', url);
      request.fields.addAll(body);
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
  }

  Future<IssuesModel> issueShowService(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}issues/$id');

    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return IssuesModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'failed: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<String> issueDeleteService(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}issues/$id');

    http.Response response;

    if (kIsWeb) {
      var request = http.Request('DELETE', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('DELETE', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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

  Future<List> issueShowAllServices() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var url = Uri.parse('${myUrl}issues');
    http.Response response;
    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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

  Future<List> showAllLawyerIssues() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var url = Uri.parse('${myUrl}lawyer/issues');
    http.Response response;
    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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

  Future<List> showAllClientIssues() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var url = Uri.parse('${myUrl}issues/client/show');
    http.Response response;
    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }

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

  Future<String> addLawyerToIssueService(
    int issueId,
    List<int> lawyerIds,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $myToken'
    };

    var url = Uri.parse('${myUrl}issues/$issueId/assign');
    var body = json.encode({"lawyer_ids": lawyerIds});

    http.Response response;

    var request = http.Request('POST', url);
    request.headers.addAll(headers);
    request.body = body;

    var streamedResponse = await request.send();
    response = await http.Response.fromStream(streamedResponse);

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
}
