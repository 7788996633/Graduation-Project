import '../models/payroll_model.dart';

import '../services/payroll_services.dart';

class PayrollRepository {
  Future<List<PayrollModel>> getPayrolls() async {
    var payrollsList = await PayrollServices().getPayrolls();
    return payrollsList
        .map(
          (e) => PayrollModel.fromJson(e),
    )
        .toList();
  }
}
