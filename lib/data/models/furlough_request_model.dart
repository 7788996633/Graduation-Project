class FurloughRequestModel {
  FurloughRequestModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.cause,
    required this.status,
    required this.covetByType,
    required this.covetById,


  });

  final int id;
  final String startDate;
  final String endDate;
  final String cause;
  final String status;
  final String covetByType;
  final int covetById;

  factory FurloughRequestModel.fromJson(Map<String, dynamic> json) {
    return FurloughRequestModel(
      id: json["id"],
      startDate: json["start_date"] ?? "",
      endDate: json["end_date"] ?? "",
      cause: json["cause"] ?? "",
      status: json["status"] ?? "",
      covetByType: json["covet_by_type"] ?? "",
      covetById: json["covet_by_id"] ?? 0,


    );
  }
}
