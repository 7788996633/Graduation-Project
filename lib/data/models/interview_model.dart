class InterviewModel {
  final int id;
  final int jobAppId;
  final int userId;

  final String result;
  final DateTime date;
  final String? note;

  InterviewModel({
    required this.id,
    required this.jobAppId,

    required this.userId,

    required this.result,
    required this.date,
    this.note,
  });
  factory InterviewModel.fromJson(Map<String, dynamic> data) {
    return InterviewModel(
      id: data['id'] ?? 0,
      jobAppId: data['jobApp_id'] ?? 0,
      userId: data['userId'] ?? 0,

      result: data['result'] ?? '',
      date: data['date'] != null
          ? DateTime.parse(data['date'])
          : DateTime.now(),
      note: data['note'],
    );
  }
}