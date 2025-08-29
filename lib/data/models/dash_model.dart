class DashCount {
  final String month;
  final double totalRevenue;
  final double totalCost;

  DashCount({
    required this.month,
    required this.totalRevenue,
    required this.totalCost,
  });

  factory DashCount.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return DashCount(
      month: json['month'] ?? '',
      totalRevenue: parseDouble(json['total_revenue']),
      totalCost: parseDouble(json['total_cost']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'total_revenue': totalRevenue,
      'total_cost': totalCost,
    };
  }
}
