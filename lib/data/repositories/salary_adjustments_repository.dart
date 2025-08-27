
import '../models/salary_adjustments_model.dart';

import '../services/salary_adjustments_services.dart';

class SalaryAdjustmentRepository {


  Future<List<SalaryAdjustment>> getSalaryAdjustments(int userId) async {
    var salaryAdjustmentList = await SalaryAdjustmentServices().getSalaryAdjustments(userId);

    return salaryAdjustmentList
        .map(
          (e) => SalaryAdjustment.fromJson(e),
    )
        .toList();
  }
}
