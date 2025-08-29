import '../models/salary_adjustments_model.dart';
import '../services/salary_adjustments_services.dart';

class SalaryAdjustmentRepository {
  Future<SalaryAdjustment?> getSalaryAdjustments(int userId) async {
    var data = await SalaryAdjustmentServices().getSalaryAdjustments(userId);

    if (data != null) {
      return SalaryAdjustment.fromJson(data);
    } else {
      return null;
    }
  }
}
