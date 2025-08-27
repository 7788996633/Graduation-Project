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
    return DashCount(
      month: json['month'] ?? '',
      totalRevenue: (json['total_revenue'] ?? 0).toDouble(),
      totalCost: (json['total_cost'] ?? 0).toDouble(),
    );
  }
}
