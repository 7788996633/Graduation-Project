class CaseType {
  final String name;

  CaseType({required this.name});

  factory CaseType.fromJson(Map<String, dynamic> json) {
    return CaseType(name: json['name'] as String);
  }
}

// موديل النسبة مع قائمة أنواع القضايا
class CaseTypePercentage {
  final List<CaseType> type;
  final double percentage;

  CaseTypePercentage({required this.type, required this.percentage});

  factory CaseTypePercentage.fromJson(Map<String, dynamic> json) {
    var typeList = (json['type'] as List)
        .map((e) => CaseType.fromJson(e))
        .toList();

    return CaseTypePercentage(
      type: typeList,
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}
