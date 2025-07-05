class EmployeeModel {
  final int id;
  final String name;
  final String type;
  final String email;
  final String status;
  final int salary;
  final String certificate;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    required this.status,
    required this.salary,
    required this.certificate,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      email: json['email'],
      status: json['status'],
      salary: json['salary'],
      certificate: json['certificate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'email': email,
      'status': status,
      'salary': salary,
      'certificate': certificate,
    };
  }
}
