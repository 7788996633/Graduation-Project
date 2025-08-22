import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';


import '../../blocs/expenses_bloc/expanses_event.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: AppColors.darkBlue.withOpacity(0.3),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => ExpenseBloc(),
                  child: ExpenseDetailsScreen(
                    expenseModel: expenseModel,
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    expenseModel.description,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Row(
                  children: [

                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        BlocProvider.of<ExpenseBloc>(context).add(
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
                    const SizedBox(width: 12),

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
      ),
    );
  }
}
