class HiringRequestModel {
  final int id;
  final String jopTitle;
  final String type;
  final String description;
  final String status;

  HiringRequestModel({
    required this.id,
    required this.jopTitle,
    required this.type,
    required this.description,
    required this.status,
  });

  factory HiringRequestModel.fromJson(json) {
    return HiringRequestModel(
      id: json['id'],
      jopTitle: json['jopTitle'],
      type: json['type'],
      description: json['description'],
      status: json['status'],
    );
  }
}
