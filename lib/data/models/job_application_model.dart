class JobApplicationModel {
  final int id;
  final int hiringReqId;
  final String userName;
  final String jobTitle;
  final String cvLink;

  final DateTime date;
  final String result;
  final String? note;

  JobApplicationModel({
    required this.id,
    required this.hiringReqId,
    required this.userName,
    required this.jobTitle,
    required this.cvLink,

    required this.date,
    required this.result,
    this.note,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) {
    return JobApplicationModel(
      id: json['id'],
      hiringReqId: json['hiring_req_id'] ?? 0,
      userName: json['user_name'] ?? '',
      jobTitle: json['job_title'] ?? '',
      cvLink: json['cv_link'] ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.parse(json['created_at']), // fallback
      result: json['result'] ?? '',
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hiring_req_id': hiringReqId,
      'user_name': userName,
      'job_title': jobTitle,
      'cv_link': cvLink,
      'date': date.toIso8601String(),
      'result': result,
      'note': note,
    };
  }
}
