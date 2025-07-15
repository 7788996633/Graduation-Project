class DashboardCount {
  final int data;

  DashboardCount({required this.data});

  factory DashboardCount.fromJson(Map<String, dynamic> json) {
    return DashboardCount(data: json['data']);
  }
}
