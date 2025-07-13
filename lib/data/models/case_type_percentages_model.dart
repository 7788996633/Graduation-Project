class CaseType {
  final String name;

  CaseType({required this.name});

  factory CaseType.fromJson(Map<String, dynamic> json) {
    return CaseType(
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class CaseTypePercentage {
  final List<CaseType> type;
  final double percentage;

  CaseTypePercentage({
    required this.type,
    required this.percentage,
  });

  factory CaseTypePercentage.fromJson(Map<String, dynamic> json) {
    var types = (json['type'] as List)
        .map((e) => CaseType.fromJson(e))
        .toList();

    return CaseTypePercentage(
      type: types,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.map((e) => e.toJson()).toList(),
      'percentage': percentage,
    };
  }
}
