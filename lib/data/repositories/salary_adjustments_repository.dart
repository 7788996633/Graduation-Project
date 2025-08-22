
import '../models/salary_adjustments_model.dart';

import '../services/salary_adjustments_services.dart';

class SalaryAdjustmentRepository {
  Future<List<SalaryAdjustment>> getSalaryAdjustments() async {
    var adjustmentsList = await SalaryAdjustmentServices().getSalaryAdjustments();
    return adjustmentsList
        .map(
          (e) => SalaryAdjustment.fromJson(e),
    )
        .toList();
  }
}
