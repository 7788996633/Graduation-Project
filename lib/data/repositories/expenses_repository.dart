
import '../models/expenses_model.dart';

import '../services/expense_services.dart';

class ExpenseRepository {
  Future<List<ExpenseModel>> getExpenses() async {
    var expensesList = await ExpenseServices().getExpenses();
    return expensesList
        .map(
          (e) => ExpenseModel.fromJson(e),
    )
        .toList();
  }
}
