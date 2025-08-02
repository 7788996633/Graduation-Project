class InvoiceModel {
  final int id;
  final String amount;
  final String status;
  final int issueId;
  final int userId;
  final int createdBy;


  InvoiceModel({
    required this.id,
    required this.amount,
    required this.status,
    required this.issueId,
    required this.userId,
    required this.createdBy,

  });

  factory InvoiceModel.fromJson(Map<String, dynamic> data) {
    return InvoiceModel(
      id: data['id'],
      amount: data['amount'] ?? '',
      status: data['status'] ?? '',
      issueId: data['issue_id'] ?? '',
      userId: data['user_id'] ?? '',
      createdBy: data['created_by'] ?? 0,

    );
  }
}
