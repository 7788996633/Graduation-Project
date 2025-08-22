class DocumentModel {
  final int id;
  final int sessionId;
  final String file;
  final String privacy;

  DocumentModel({
    required this.id,
    required this.sessionId,
    required this.file,
    required this.privacy,

  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      sessionId: json['session_id'],
      file: json['file'],
      privacy: json['privacy'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'file': file,
      'privacy': privacy,

    };
  }
}
