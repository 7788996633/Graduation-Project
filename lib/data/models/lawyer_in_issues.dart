class LawyerInIssues {
  LawyerInIssues({
    required this.id,
    required this.licenseNumber,
    required this.experienceYears,
    required this.salary,
    required this.certificate,
    required this.type,
    required this.specialization,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
    required this.user,
  });

  final int id;
  final String licenseNumber;
  final int experienceYears;
  final String salary;
  final String certificate;
  final String type;
  final String specialization;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot pivot;
  final User user;

  factory LawyerInIssues.fromJson(Map<String, dynamic> json) {
    return LawyerInIssues(
      id: json["id"],
      licenseNumber: json["license_number"],
      experienceYears: json["experience_years"],
      salary: json["salary"],
      certificate: json["certificate"],
      type: json["type"],
      specialization: json["specialization"],
      userId: json["user_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: Pivot.fromJson(json["pivot"]),
      user: User.fromJson(json["user"]),
    );
  }
}

class Pivot {
  Pivot({
    required this.issueId,
    required this.lawyerId,
  });

  final int issueId;
  final int lawyerId;

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      issueId: json["issue_id"],
      lawyerId: json["lawyer_id"],
    );
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String email;
  final dynamic emailVerifiedAt;
  final int roleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      roleId: json["role_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
