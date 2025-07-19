import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import '../../constant.dart';
import '../models/session_model.dart';

class SessionServices {
  Future<List> getSessions() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final url = Uri.parse('${myUrl}sessions');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<List> getSessionsByIssueId(int issueId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final url = Uri.parse('${myUrl}sessions/issue/$issueId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<List> getLawyerSessions() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final url = Uri.parse('${myUrl}lawyer/sessions');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<List> getClientSessions() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final url = Uri.parse('${myUrl}sessions/client/show');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['data'];
    } else {
      return [];
    }
  }

  Future<SessionModel> getSessionById(int sessionId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final url = Uri.parse('${myUrl}sessions/$sessionId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('GET', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return SessionModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('failed: ${jsonResponse['message']}');
    }
  }

  Future<String> createSession(
    int sessionTypeId,
    int lawyerId,
    int issueId,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final url = Uri.parse('${myUrl}sessions/$issueId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('POST', url);
      request.headers.addAll({
        ...headers,
        'Content-Type': 'application/x-www-form-urlencoded',
      });
      request.bodyFields = {
        'session_type_id': sessionTypeId.toString(),
        'lawyer_id': lawyerId.toString(),
      };

      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields.addAll({
        'session_type_id': sessionTypeId.toString(),
        'lawyer_id': lawyerId.toString(),
      });

      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    }

    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message']}';
    }
  }

  Future<String> updateSession(
      String outcome, int isAttend, int sessionId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    final url = Uri.parse('${myUrl}sessions/$sessionId');
    var body = {
      'outcome': outcome,
      'isAttend': isAttend.toString(),
    };

    var request = http.Request('POST', url);
    request.headers.addAll(headers);
    request.bodyFields = body;

    var streamed = await request.send();
    var response = await http.Response.fromStream(streamed);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
      return jsonResponse['message'];
    } else {
      return 'failed: ${jsonResponse['message']}';
    }
  }

  Future<String> deleteSession(int sessionId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };

    final url = Uri.parse('${myUrl}sessions/$sessionId');
    http.Response response;

    if (kIsWeb) {
      var request = http.Request('DELETE', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
    } else {
      var request = http.MultipartRequest('DELETE', url);
      request.headers.addAll(headers);
      var streamed = await request.send();
      response = await http.Response.fromStream(streamed);
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

Future<String> markSessionAsAttendance(int sessionId) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer $myToken',
  };

  var request = http.Request(
    'PUT',
    Uri.parse('${myUrl}lawyer/sessions/$sessionId/attend'),
  );
  request.bodyFields = {
    'isAttend': '1',
  };

  request.headers.addAll(headers);
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  var jsonResponse = json.decode(response.body);
  print(jsonResponse);

  if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
    return jsonResponse['message'];
  } else {
    return 'failed: ${jsonResponse['message']}';
  }
}

Future<String> evaluateLawyerInSession(
    int sessionId, int lawyerId, String notes, int points) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': 'Bearer $myToken',
  };

  var request = http.Request(
    'POST',
    Uri.parse('${myUrl}admin/lawyer-points/evaluate/$sessionId/$lawyerId'),
  );
  request.bodyFields = {
    'points': points.toString(),
    'notes': notes,
  };

  request.headers.addAll(headers);
  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  var jsonResponse = json.decode(response.body);
  print(jsonResponse);

  if (response.statusCode == 200 && jsonResponse['status'] == 'success') {
    return jsonResponse['message'];
  } else {
    return 'failed: ${jsonResponse['message']}';
  }
}
