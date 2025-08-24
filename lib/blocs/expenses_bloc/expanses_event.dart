import 'package:meta/meta.dart';

@immutable
sealed class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final String description;
  final double amount;
  final String type;

  AddExpenseEvent({
    required this.description,
    required this.amount,
    required this.type,
  });
}

class GetExpenseByIdEvent extends ExpenseEvent {
  final int expenseId;

  GetExpenseByIdEvent({required this.expenseId});
}

class GetAllExpensesEvent extends ExpenseEvent {}

class SearchExpensesByDescriptionEvent extends ExpenseEvent {
  final String description;

  SearchExpensesByDescriptionEvent({required this.description});
}

class UpdateExpenseEvent extends ExpenseEvent {
  final int expenseId;
  final String description;
  final double amount;

  UpdateExpenseEvent({
    required this.expenseId,
    required this.description,
    required this.amount,
  });
}

class DeleteExpenseEvent extends ExpenseEvent {
  final int expenseId;

  DeleteExpenseEvent({required this.expenseId});
}
