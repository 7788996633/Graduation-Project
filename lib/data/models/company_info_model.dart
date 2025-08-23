import 'employee_model.dart';
import 'lawyer_model.dart';

class CompanyInfoModel {
  final Company company;
  final List<EmployeeModel> employees;
  final List<LawyerModel> lawyers;

  CompanyInfoModel({
    required this.company,
    required this.employees,
    required this.lawyers,
  });

  factory CompanyInfoModel.fromJson(Map<String, dynamic> json) {
    return CompanyInfoModel(
      company: Company.fromJson(json['company'] ?? {}),
      employees: (json['employees'] as List<dynamic>? ?? [])
          .map((e) => EmployeeModel.fromJson(e))
          .toList(),
      lawyers: (json['lawyers'] as List<dynamic>? ?? [])
          .map((l) => LawyerModel.fromJson(l))
          .toList(),
    );
  }
}

class Company {
  final int id;
  final String name;
  final String address;
  final String foundationDate;
  final String description;
  final String goals;
  final String vision;


  Company({
    required this.id,
    required this.name,
    required this.address,
    required this.foundationDate,
    required this.description,
    required this.goals,
    required this.vision,

  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      address: json["address"] ?? "",
      foundationDate: json["foundation_date"] ?? "",
      description: json["description"] ?? "",
      goals: json["goals"] ?? "",
      vision: json["vision"] ?? "",

    );
  }
}


