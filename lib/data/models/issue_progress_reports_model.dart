
class IssueProgressReportModel {
  final int id;
  final String report;
  final int preSessionCount;
  final int sessionId;
  final DateTime createdAt;
  final DateTime updatedAt;

  IssueProgressReportModel({
    required this.id,
    required this.report,
    required this.preSessionCount,
    required this.sessionId,
    required this.createdAt,
    required this.updatedAt,

  });

  factory IssueProgressReportModel.fromJson(Map<String, dynamic> data) {
    return IssueProgressReportModel(
      id: data['id'],
      report: data['report'] ?? '',
      preSessionCount: data['pre_session_count'] ?? 0,
      sessionId: data['session_id'] ?? 0,
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }
}
