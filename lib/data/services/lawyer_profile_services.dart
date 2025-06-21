import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constant.dart';
import '../models/lawyer_model.dart';

class LawyerProfileServices {
  Future<LawyerModel> getMyLawyerProfile() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request('GET', Uri.parse('${myUrl}lawyer/profile'));
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return LawyerModel.fromJson(jsonResponse['data']);
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'failed: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<LawyerModel> getLawyerProfileById(int lawyerId) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request = http.Request('GET', Uri.parse('${myUrl}lawyers/$lawyerId'));
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      if (jsonResponse['status'] == 'success') {
        return LawyerModel.fromJson(
          jsonResponse['data'],
        );
      } else {
        throw Exception('failed: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'failed: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  Future<String> creatLawyerProrile(
    String licenseNumber,
    String experienceYears,
    String specialization,
    String certificatePath,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${myUrl}lawyers/create'));
    request.fields.addAll({
      'license_number': licenseNumber,
      'experience_years': experienceYears,
      'specialization': specialization,
      'certificate': certificatePath,
      'type': 'lawyer',
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

  Future<String> updateLawyerProrile(
    String licenseNumber,
    String experienceYears,
    String specialization,
    String? certificatePath,
    String phone,
    String? imagePath,
    String address,
    String age,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${myUrl}lawyer/profile'));
    request.fields.addAll(
      {
        'age': age,
        'specialization': specialization,
        'phone': phone,
        'experience_years': experienceYears,
        'address': address,
        'license_number': licenseNumber,
      },
    );
    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imagePath,
      ));
      print(
          '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++imagePath: $imagePath');
    }

    if (certificatePath != null) {
      request.files.add(
          await http.MultipartFile.fromPath('certificate', certificatePath));
      print(
          '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++certificatePath: $certificatePath');
    }

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

  Future<String> deleteProfile(int lawyerid) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken'
    };
    var request =
        http.Request('DELETE', Uri.parse('${myUrl}lawyers/$lawyerid'));
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
