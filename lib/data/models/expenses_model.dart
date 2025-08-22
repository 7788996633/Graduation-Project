class ExpenseModel {
  final int id;
  final String description;
  final double? amount;
  final String type;
  final String? relatedId;
  final String? relatedType;


  ExpenseModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    this.relatedId,
    this.relatedType,

  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      description: json['description'] ?? '',
      amount: json['amount'] ?? '0.00',
      type: json['type'] ?? '',
      relatedId: json['related_id']?.toString(),
      relatedType: json['related_type'],

    );
  }
}
