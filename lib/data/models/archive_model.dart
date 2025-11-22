class ArchiveModel {
  final int id;

  final int issueId;

  ArchiveModel({
    required this.id,
    required this.issueId,
  });

  factory ArchiveModel.fromJson(Map<String, dynamic> data) {
    return ArchiveModel(
      id: data['id'],
      issueId: data['issue_Id'],
    );
  }
}
