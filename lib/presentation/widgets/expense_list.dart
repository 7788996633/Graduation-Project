import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/expenses_bloc/expanses_event.dart';
import '../../blocs/expenses_bloc/expanses_state.dart';
import '../../blocs/expenses_bloc/expenses_bloc.dart';

import '../../data/models/expenses_model.dart';
import 'expense_item.dart'; // لازم يكون هذا الwidget موجود

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key, required this.bloc});
  final ExpenseBloc bloc;

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  List<ExpenseModel> expenseList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllExpensesEvent());
        } else if (state is ExpenseFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseListLoaded) {
            expenseList = state.list;
            if (expenseList.isEmpty) {
              return const Center(child: Text('There are no expenses.'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: expenseList.length,
                itemBuilder: (context, index) {
                  return ExpenseItem(
                    expenseModel: expenseList[index],
                  );
                },
              ),
            );
          } else if (state is ExpenseFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
