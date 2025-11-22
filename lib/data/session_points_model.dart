class SessionPointsModel {
  final int sessionId;
  final String lawyerName;
  final double percentage;
  final double amount;
  final int sessionPoints;

  SessionPointsModel(
      {required this.sessionId,
      required this.lawyerName,
      required this.percentage,
      required this.amount,
      required this.sessionPoints});

  factory SessionPointsModel.fromJson(json) {
    return SessionPointsModel(
      sessionId: int.tryParse(json['session_id'].toString()) ?? 0,
      lawyerName: json['lawyer_name'] ?? 'Unknown',
      percentage: double.tryParse(json['percentage'].toString()) ?? 0.0,
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      sessionPoints:
          int.tryParse(json['point for this session'].toString()) ?? 0,
    );
  }
}
