class PayrollModel {
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


  // الحقول الجديدة
  final double payment;
  final double allowances;
  final double deductions;
  final String status;

  PayrollModel({
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

    required this.payment,
    required this.allowances,
    required this.deductions,
    required this.status,
  });

  factory PayrollModel.fromJson(Map<String, dynamic> data) {
    return PayrollModel(
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

      payment: double.tryParse(data['payment']?.toString() ?? '0') ?? 0.0,
      allowances: double.tryParse(data['allowances']?.toString() ?? '0') ?? 0.0,
      deductions: double.tryParse(data['deductions']?.toString() ?? '0') ?? 0.0,
      status: data['status'] ?? '',
    );
  }
}
