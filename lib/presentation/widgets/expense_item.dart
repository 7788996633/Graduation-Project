import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // تقليل الـ horizontal padding لعرض أوسع
      child: SizedBox(
        width: double.infinity,
        child: BlocConsumer<ExpenseBloc, ExpenseState>(
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
          builder: (context, state) {
            return Card(
              color: Colors.grey.shade200,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<ExpenseBloc>(context),
                        child: ExpenseDetailsScreen(expenseModel: expenseModel),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.darkBlue.withOpacity(0.1),
                        child: const Icon(
                          Icons.attach_money_rounded,
                          color: AppColors.darkBlue,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenseModel.description,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkBlue,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Type: ${expenseModel.type}",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkBlue.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              context.read<ExpenseBloc>().add(
                                DeleteExpenseEvent(expenseId: expenseModel.id),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.darkBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.delete,
                                color: AppColors.darkBlue,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.darkBlue,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
