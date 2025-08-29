class CaseTypePercentage {
  final String type;
  final double percentage;

  CaseTypePercentage({
    required this.type,
    required this.percentage,
  });

  factory CaseTypePercentage.fromJson(Map<String, dynamic> json) {
    return CaseTypePercentage(
      type: json['type'] ?? '',
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'percentage': percentage,
    };
  }
}
