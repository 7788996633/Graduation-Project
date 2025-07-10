class SessionModel {
  SessionModel({

    required this.sessionId,
    this.type,               // nullable
    required this.outcome,
    required this.lawyerId,
    required this.issueId,
    required this.isAttend,
    required this.sessionTypeId,

  });

  final int sessionId;
  final String? type;       // هنا جعلناه nullable
  final String outcome;
  final int lawyerId;
  final int issueId;
  final int isAttend;
  final int sessionTypeId;


  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionId: json['id'] ?? 0,
      type: json['type'] as String?,   // nullable
      outcome: json['outcome'] ?? '',
      lawyerId: json['lawyer_id'] ?? 0,
      issueId: json['issue_id'] ?? 0,
      isAttend: json['is_attend'] ?? 0,
      sessionTypeId: json['session_type_id'] ?? 0,

    );
  }
}
