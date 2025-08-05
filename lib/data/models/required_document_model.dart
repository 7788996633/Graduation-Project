class RequiredDocumentModel {
  RequiredDocumentModel({
    required this.id,
    required this.issueId,
    required this.file,
    required this.requireFileType,
    required this.note,
    required this.status,
  });

  final int id;
  final int issueId;
  final String? file;
  final String? note;
  final String requireFileType;
  final String status;

  factory RequiredDocumentModel.fromJson(Map<String, dynamic> json) {
    return RequiredDocumentModel(
      id: json["id"],
      issueId: json["issue_id"],
      file: json["file"],
      requireFileType: json["require_file_type"],
      note: json["note"],
      status: json["status"],
    );
  }
}
