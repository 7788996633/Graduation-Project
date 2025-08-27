import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expenses_bloc/expanses_event.dart';
import '../../../blocs/expenses_bloc/expanses_state.dart';
import '../../../blocs/expenses_bloc/expenses_bloc.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/expense_item.dart'; // استبدل ExpenseList
import 'add_expense_screen.dart';

class ListExpensesScreen extends StatefulWidget {
  const ListExpensesScreen({super.key});

  @override
  State<ListExpensesScreen> createState() => _ListExpensesScreenState();
}

class _ListExpensesScreenState extends State<ListExpensesScreen> {
  late ExpenseBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ExpenseBloc>(context);
    bloc.add(GetAllExpensesEvent());
  }

  Future<void> _onRefresh() async {
    bloc.add(GetAllExpensesEvent());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Expenses',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Expense',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ExpenseBloc(),
                child: const AddExpenseScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              if (state is ExpenseLoaded ) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExpenseFail) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(state.errMsg),
                      ),
                    ),
                  ],
                );
              } else if (state is ExpenseListLoaded) {
                final expenseList = state.list;
                if (expenseList.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('No Expenses Available'),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: expenseList.length,
                  itemBuilder: (context, index) {
                    return ExpenseItem(
                      expenseModel: expenseList[index],
                    );
                  },
                );
              }
              // الحالة المبدئية قابلة للسحب
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
              );
            },
          ),
        ),
      ),
    );
  }
}
