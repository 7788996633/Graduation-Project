import '../models/case_type_percentages_model.dart';
import '../services/case_type_percentages_service.dart';

class CaseTypeRepository {
  final CaseTypeService _caseTypeService = CaseTypeService();

  Future<List<CaseTypePercentage>> getCaseTypePercentages() async {
    return await _caseTypeService.fetchCaseTypePercentages();
  }
}
