class EmployeeModel {
  EmployeeModel({
    required this.id,
    required this.salary,
    required this.certificate,
    required this.hireDate,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int salary;
  final String certificate;
  final DateTime? hireDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json["id"],
      salary: json["salary"],
      certificate: json["certificate"],
      hireDate: DateTime.tryParse(json["hire_date"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
