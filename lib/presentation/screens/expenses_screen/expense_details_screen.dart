import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../../data/models/expenses_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../expenses_screen/update_expense_screen.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  final ExpenseModel expenseModel;

  const ExpenseDetailsScreen({super.key, required this.expenseModel});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  late ExpenseModel expense;

  @override
  void initState() {
    super.initState();
    expense = widget.expenseModel;
  }

  void refreshData(ExpenseModel updated) {
    setState(() {
      expense = updated;
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CustomActionAppBar(title: 'Expense Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(Icons.attach_money_rounded, size: 72, color: AppColors.darkBlue),
                ),
                const SizedBox(height: 20),
                _buildInfoRow(
                  icon: Icons.description_outlined,
                  label: 'Description',
                  value: expense.description,
                ),
                _buildInfoRow(
                  icon: Icons.monetization_on,
                  label: 'Amount',
                  value: expense.amount.toString(),
                ),
                _buildInfoRow(
                  icon: Icons.category,
                  label: 'Type',
                  value: expense.type,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final updatedExpense = await Navigator.push<ExpenseModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ExpenseBloc(),
                child: UpdateExpenseScreen(expense: expense),
              ),
            ),
          );

          if (updatedExpense != null) {
            refreshData(updatedExpense);
          }
        },
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          'Edit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
    );
  }
}
