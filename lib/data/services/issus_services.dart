import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
    var request = http.Request('PUT', Uri.parse('${myUrl}issues/$id'));

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

  Future<String> issuePriorityUpdateService(
    int id,
    String priority,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${myUrl}issues/$id/priority'));
    request.fields.addAll({'priority': priority});

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

  Future<IssuesModel> issueShowService(int id) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${myUrl}issues/$id'));

    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return IssuesModel.fromJson(
          jsonResponse['data'],
        );
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
        //زبط بحيث اذا فشل يرجع ايدي سالب وخزن السبب واعرضو لا تنسى
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
    var request =
        http.MultipartRequest('DELETE', Uri.parse('${myUrl}issues/$id'));

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

  Future<List> issueShowAllServices() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${myUrl}issues'));

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

  Future<String> addLawyerToIssueService(
    int issueId,
    List<int> lawyerIds,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.Request('POST', Uri.parse('${myUrl}issues/$issueId/assign'));
    request.body = json.encode({"lawyer_ids": lawyerIds});

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
