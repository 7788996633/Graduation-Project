class SessionModel {
  SessionModel({
    required this.sessionId,
    this.type, // nullable
    required this.outcome,
    required this.lawyerId,
    required this.issueId,
    required this.isAttend,
    required this.sessionTypeId,
    this.createdAt,
  });

  final int sessionId;
  final String? type;
  final String outcome;
  final int lawyerId;
  final int issueId;
  final int isAttend;
  final int sessionTypeId;
  final DateTime? createdAt;

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionId: json['id'] ?? 0,
      type: json['type'] as String?,
      outcome: json['outcome'] ?? '',
      lawyerId: json['lawyer_id'] ?? 0,
      issueId: json['issue_id'] ?? 0,
      isAttend: json['is_attend'] ?? 0,
      sessionTypeId: json['session_type_id'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}

// Enum for attendance status
enum AttendStatus { attend, absent }

// Optional helper functions if needed:
String attendStatusToString(AttendStatus status) {
  return status.name[0].toUpperCase() + status.name.substring(1);
}

AttendStatus intToAttendStatus(int value) {
  return value == 1 ? AttendStatus.attend : AttendStatus.absent;
}

int attendStatusToInt(AttendStatus status) {
  return status == AttendStatus.attend ? 1 : 0;
}
