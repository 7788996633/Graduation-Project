class SalaryAdjustment {
  final int id;
  final String employableType;
  final int employableId;
  final String type;
  final String reason;
  final double amount;
  final int processed;
  final DateTime effectiveDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Employable employable;

  SalaryAdjustment({
    required this.id,
    required this.employableType,
    required this.employableId,
    required this.type,
    required this.reason,
    required this.amount,
    required this.processed,
    required this.effectiveDate,
    required this.createdAt,
    required this.updatedAt,
    required this.employable,
  });

  factory SalaryAdjustment.fromJson(Map<String, dynamic> data) {
    return SalaryAdjustment(
      id: data['id'] ?? 0,
      employableType: data['employable_type'] ?? '',
      employableId: data['employable_id'] ?? 0,
      type: data['type'] ?? '',
      reason: data['reason'] ?? '',
      amount: double.tryParse(data['amount']?.toString() ?? '0') ?? 0.0,
      processed: data['processed'] ?? 0,
      effectiveDate: data['effective_date'] != null
          ? DateTime.parse(data['effective_date'])
          : DateTime.now(),
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : DateTime.now(),
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : DateTime.now(),
      employable: data['employable'] != null
          ? Employable.fromJson(data['employable'])
          : Employable.empty(),
    );
  }
}

class Employable {
  final int id;
  final double salary;
  final String certificate;
  final DateTime hireDate;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Employable({
    required this.id,
    required this.salary,
    required this.certificate,
    required this.hireDate,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employable.fromJson(data) {
    return Employable(
      id: data['id'] ?? 0,
      salary: double.tryParse(data['salary']?.toString() ?? '0') ?? 0.0,
      certificate: data['certificate'] ?? '',
      hireDate: data['hire_date'] != null
          ? DateTime.parse(data['hire_date'])
          : DateTime.now(),
      userId: data['user_id'] ?? 0,
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'])
          : DateTime.now(),
      updatedAt: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : DateTime.now(),
    );
  }

  factory Employable.empty() {
    return Employable(
      id: 0,
      salary: 0.0,
      certificate: '',
      hireDate: DateTime.now(),
      userId: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
