import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../../data/models/expenses_model.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../../themes.dart';
import '../expenses_screen/update_expense_screen.dart';


class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({super.key, required this.expenseModel});
  final ExpenseModel expenseModel;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomActionAppBar(
        title: 'Expense Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // البطاقة الرئيسية
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الأيقونة الرئيسية
                    Center(
                      child: Icon(
                        Icons.attach_money_rounded,
                        size: 80,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // الوصف
                    Text(
                      expense.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // المبلغ
                    Text(
                      'Amount: ${expense.amount}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // النوع
                    Text(
                      'Type: ${expense.type}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // أيقونة إضافية
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.article, color: AppColors.darkBlue, size: 28),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // فتح شاشة تعديل المصروف
          final result = await Navigator.push<ExpenseModel>(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => ExpenseBloc(),
                child: UpdateExpenseScreen(expense: expense),
              ),
            ),
          );

          if (result != null) {
            refreshData(result);
          }
        },
        icon: const Icon(Icons.edit),
        label: const Text(
          'Edit',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
        elevation: 6,
        hoverElevation: 12,
        extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
