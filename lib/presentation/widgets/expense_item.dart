import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/expenses_bloc/expanses_event.dart';
import '../../blocs/expenses_bloc/expanses_state.dart';
import '../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../data/models/expenses_model.dart';
import '../../themes.dart';
import '../screens/expenses_screen/expense_details_screen.dart';

class ExpenseItem extends StatefulWidget {
  const ExpenseItem({super.key, required this.expenseModel});
  final ExpenseModel expenseModel;

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ExpenseBloc>(context),
                    child: ExpenseDetailsScreen(expenseModel: widget.expenseModel),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // وصف المصروف + زر الحذف
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.darkBlue.withOpacity(0.2),
                          child: const Icon(
                            Icons.attach_money_rounded,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.expenseModel.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Type: ${widget.expenseModel.type}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ExpenseBloc>().add(
                              DeleteExpenseEvent(
                                  expenseId: widget.expenseModel.id),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
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
    );
  }
}
