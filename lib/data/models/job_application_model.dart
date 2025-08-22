class JobApplicationModel {
  final int id;
  final int hiringRequestId;
  final int userId;
  final String jobTitle;
  final String cvLink;
  final DateTime date;
  final String result;
  final String? note;
  final String userName;
  final String status;
  final DateTime submittedAt;

  JobApplicationModel({
    required this.id,
    required this.hiringRequestId,
    required this.userId,
    required this.jobTitle,
    required this.cvLink,
    required this.date,
    required this.result,
    this.note,
    required this.userName,
    required this.status,
    required this.submittedAt,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> data) {
    return JobApplicationModel(
      id: data['id'] ?? 0,
      hiringRequestId: data['hiring_request_id'] ?? 0,
      userId: data['user_id'] ?? 0,
      jobTitle: data['job_title'] ?? '',
      cvLink: data['cv_link'] ?? '',
      date: data['date'] != null
          ? DateTime.parse(data['date'])
          : (data['created_at'] != null ? DateTime.parse(data['created_at']) : DateTime.now()),
      result: data['result'] ?? '',
      note: data['note'],
      userName: data['user_name'] ?? 'Unknown',
      status: data['status'] ?? 'Pending',
      submittedAt: data['submitted_at'] != null
          ? DateTime.parse(data['submitted_at'])
          : DateTime.now(),
    );
  }
}
