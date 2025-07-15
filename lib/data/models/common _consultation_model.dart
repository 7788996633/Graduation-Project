class CommonConsultationModel {
  CommonConsultationModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String question;
  final String answer;
  final String createdAt;
  final String updatedAt;

  factory CommonConsultationModel.fromJson(Map<String, dynamic> json) {
    return CommonConsultationModel(
      id: json["id"],
      question: json["question"] ?? "",
      answer: json["answer"] ?? "",
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
    );
  }
}
