import 'dart:core';
import 'package:bloc/bloc.dart';

import '../../data/models/expenses_model.dart';

import '../../data/repositories/expenses_repository.dart';

import '../../data/services/expense_services.dart';
import 'expanses_event.dart';
import 'expanses_state.dart';


class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitial()) {
    List<ExpenseModel> allExpenses = [];

    on<ExpenseEvent>((event, emit) async {
      if (event is AddExpenseEvent) {
        emit(ExpenseLoading());
        try {
          String result = await ExpenseServices()
              .addExpense(event.description, event.amount, event.type);
          emit(ExpenseSuccess(successMsg: result));
        } catch (e) {
          emit(ExpenseFail(errMsg: e.toString()));
        }
      } else if (event is GetExpenseByIdEvent) {
        emit(ExpenseLoading());
        try {
          ExpenseModel expense = await ExpenseServices()
              .getExpenseById(event.expenseId);
          emit(ExpenseLoaded(expense: expense));
        } catch (e) {
          emit(ExpenseFail(errMsg: e.toString()));
        }
      } else if (event is GetAllExpensesEvent) {
        emit(ExpenseLoading());
        try {
          allExpenses = await ExpenseRepository().getExpenses();
          emit(ExpenseListLoaded(list: allExpenses));
        } catch (e) {
          emit(ExpenseFail(errMsg: e.toString()));
        }
      } else if (event is SearchExpensesByDescriptionEvent) {
        emit(ExpenseLoading());
        try {
          final descriptionLower = event.description.trim().toLowerCase();

          final filteredList = allExpenses.where((expense) {
            final name = expense.description.toLowerCase();
            return name.contains(descriptionLower);
          }).toList();

          emit(ExpenseListLoaded(list: filteredList));
        } catch (e) {
          emit(ExpenseFail(errMsg: e.toString()));
        }
      } else if (event is UpdateExpenseEvent) {
        emit(ExpenseLoading());
        try {
          String result = await ExpenseServices()
              .updateExpense(event.expenseId,event.description, event.amount);
          emit(ExpenseSuccess(successMsg: result));
        } catch (e) {
          emit(ExpenseFail(errMsg: e.toString()));
        }
      } else if (event is DeleteExpenseEvent) {
        emit(ExpenseLoading());
        try {
          String result =
          await ExpenseServices().deleteExpense(event.expenseId);
          emit(ExpenseSuccess(successMsg: result));
        } catch (e) {
          emit(ExpenseFail(errMsg: e.toString()));
        }
      }
    });
  }
}
