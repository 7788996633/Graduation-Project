class EmployeeModel {
  final int id;
  final int salary;
  final String certificate;
  final DateTime hireDate;
  final int userId;

  EmployeeModel({
    required this.id,
    required this.salary,
    required this.certificate,
    required this.hireDate,
    required this.userId,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    int parseInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    DateTime parseDate(String? dateStr) {
      if (dateStr == null || dateStr.isEmpty) {
        return DateTime(1970); // تاريخ افتراضي أو يمكنك رمي استثناء
      }
      try {
        return DateTime.parse(dateStr);
      } catch (e) {
        return DateTime(1970);
      }
    }

    return EmployeeModel(
      id: parseInt(json['id']),
      salary: parseInt(json['salary']),
      certificate: json['certificate'] ?? '',
      hireDate: parseDate(json['hire_date']),
      userId: parseInt(json['user_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salary': salary,
      'certificate': certificate,
      'hire_date': hireDate.toIso8601String(),
      'user_id': userId,
    };
  }
}