class SessionTypeModel {
  final int id;

  final int? points;
  final String description;
  final DateTime date;
  final String type;

  SessionTypeModel({
    required this.id,
    this.points,
    required this.description,
    required this.date,
    required this.type,
  });

  factory SessionTypeModel.fromJson(Map<String, dynamic> data) {
    return SessionTypeModel(
      id: data['id'],
      points: data['points'],
      description: data['description'] ?? '',
      date: DateTime.parse(data['date'] ?? DateTime.now().toIso8601String()),
      type: data['type'] ?? '',
    );
  }
}
