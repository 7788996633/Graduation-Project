class SessionAppointementModel {
  final int id;
  final int sessionId;
  final DateTime date;
  final String type;

  SessionAppointementModel(
      {required this.id,
      required this.sessionId,
      required this.date,
      required this.type});
  factory SessionAppointementModel.fromJson(data) {
    return SessionAppointementModel(
      id: data['id'],
      sessionId: data['session_id'],
      date: DateTime.parse(
        data['date'],
      ),
      type: data['type'],
    );
  }
}
