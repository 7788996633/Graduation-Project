




import '../../data/models/expenses_model.dart';

sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {}

final class ExpenseLoading extends ExpenseState {}

final class ExpenseSuccess extends ExpenseState {
  final String successMsg;

  ExpenseSuccess({required this.successMsg});
}

final class ExpenseLoaded extends ExpenseState {
  final ExpenseModel expense;

  ExpenseLoaded({required this.expense});
}

final class ExpenseListLoaded extends ExpenseState {
  final List<ExpenseModel> list;

  ExpenseListLoaded({required this.list});
}

final class ExpenseFail extends ExpenseState {
  final String errMsg;

  ExpenseFail({required this.errMsg});
}
