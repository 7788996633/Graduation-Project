import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expenses_bloc/expanses_event.dart';
import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/expense_list.dart';
import '../../widgets/custom_search_bar.dart';

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

  void _onSearch(String description) {
    if (description.trim().isNotEmpty) {
      bloc.add(SearchExpensesByDescriptionEvent(description: description));
    } else {
      bloc.add(GetAllExpensesEvent());
    }
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
        child: Column(
          children: [
            CustomSearchBar(
              hint: 'Search by Description',
              onSearch: _onSearch,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  bloc.add(GetAllExpensesEvent());
                  // ضع تأخير بسيط حتى يتم تحديث البيانات
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: ExpenseList(bloc: bloc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
