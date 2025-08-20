class SessionPointsModel {
  final int sessionId;
  final String lawyerName;
  final double percentage;
  final int amount;
  final int sessionPoints;

  SessionPointsModel(
      {required this.sessionId,
      required this.lawyerName,
      required this.percentage,
      required this.amount,
      required this.sessionPoints});

  factory SessionPointsModel.fromJson(data) {
    return SessionPointsModel(
      sessionId: int.parse(
        data['session_id'],
      ),
      lawyerName: data['lawyer_name'].toString(),
      percentage: double.parse(data['percentage']),
      amount: int.parse(
        data['amount'],
      ),
      sessionPoints: int.parse(data['point for this session']),
    );
  }
}
