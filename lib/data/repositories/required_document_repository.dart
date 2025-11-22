import '../models/required_document_model.dart';
import '../services/required_document_services.dart';

class RequiredDocumentRepository {
  Future<List<RequiredDocumentModel>> getRequiredDocuments() async {
    var requiredDocumentsList =
        await RequiredDocumentServices().getRequiredDocuments();
    return requiredDocumentsList
        .map(
          (e) => RequiredDocumentModel.fromJson(e),
        )
        .toList();
  }

  Future<List<RequiredDocumentModel>> getRequiredDocumentsByissueId(
      int issueId) async {
    var requiredDocumentsList =
        await RequiredDocumentServices().getRequiredDocumentsByIssueId(issueId);
    return requiredDocumentsList
        .map(
          (e) => RequiredDocumentModel.fromJson(e),
        )
        .toList();
  }
}
