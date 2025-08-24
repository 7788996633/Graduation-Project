import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../blocs/expenses_bloc/expanses_event.dart';
import '../../blocs/expenses_bloc/expanses_state.dart';
import '../../blocs/expenses_bloc/expenses_bloc.dart';

import '../../data/models/expenses_model.dart';
import '../../themes.dart';
import '../screens/expenses_screen/expense_details_screen.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expenseModel});
  final ExpenseModel expenseModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: BlocListener<ExpenseBloc, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.successMsg),
              ),
            );
          } else if (state is ExpenseFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.errMsg),
              ),
            );
          }
        },
        child: Card(
          elevation: 5,
          color: Colors.grey.shade200, // اللون الرمادي الفاتح للكارد
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final updatedExpense = await Navigator.push<ExpenseModel>(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => ExpenseBloc(),
                    child: ExpenseDetailsScreen(expenseModel: expenseModel),
                  ),
                ),
              );
              // يمكن إضافة أي تحديثات بعد العودة من الشاشة
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.darkBlue.withOpacity(0.1),
                    child: const Icon(
                      Icons.attach_money_rounded,
                      color: AppColors.darkBlue,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expenseModel.description,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.receipt_long,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              expenseModel.type, // عرض نوع المصروف
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                context.read<ExpenseBloc>().add(
                                  DeleteExpenseEvent(
                                      expenseId: expenseModel.id),
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: AppColors.darkBlue,
                                size: 20,
                              ),
                              tooltip: 'Delete Expense',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.darkBlue,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
