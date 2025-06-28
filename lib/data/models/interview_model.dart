class InterviewModel {
  final int id;
  final String result;
  final DateTime date;
  final String? note;

  InterviewModel({
    required this.id,
    required this.result,
    required this.date,
    this.note,
  });

  factory InterviewModel.fromJson(Map<String, dynamic> data) {
    return InterviewModel(
      id: data['id'],
      result: data['result'] ?? '',
      date: DateTime.parse(data['date'] ?? DateTime.now().toIso8601String()),
      note: data['note'],
    );
  }
}
