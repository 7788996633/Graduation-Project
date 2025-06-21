class InterviewModel {
  final int id;
  final int? points;
  final String description;
  final DateTime date;
  final String type;

  InterviewModel({
    required this.id,
    this.points,
    required this.description,
    required this.date,
    required this.type,
  });

  factory InterviewModel.fromJson(Map<String, dynamic> data) {
    return InterviewModel(
      id: data['id'],
      points: data['points'],
      description: data['description'] ?? '',
      date: DateTime.parse(data['date'] ?? DateTime.now().toIso8601String()),
      type: data['type'] ?? '',
    );
  }
}
