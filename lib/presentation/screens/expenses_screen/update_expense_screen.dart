import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../../blocs/expenses_bloc/expanses_event.dart';
import '../../../blocs/expenses_bloc/expanses_state.dart';
import '../../../data/models/expenses_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateExpenseScreen extends StatefulWidget {
  final ExpenseModel expense;

  const UpdateExpenseScreen({super.key, required this.expense});

  @override
  State<UpdateExpenseScreen> createState() => _UpdateExpenseScreenState();
}

class _UpdateExpenseScreenState extends State<UpdateExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late ExpenseBloc _bloc;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.expense.description ?? '');
    _amountController =
        TextEditingController(text: widget.expense.amount?.toString() ?? '');
    _bloc = ExpenseBloc();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    if (_formKey.currentState!.validate()) {
      final amount = double.tryParse(_amountController.text.trim());
      if (amount == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid number for amount'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      _bloc.add(UpdateExpenseEvent(
        expenseId: widget.expense.id,
        description: _descriptionController.text.trim(),
        amount: amount,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExpenseBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Expense'),
        body: BlocConsumer<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );
              Navigator.pop(
                context,
                ExpenseModel(
                  id: widget.expense.id,
                  description: _descriptionController.text.trim(),
                  amount: _amountController.text.trim(),
                  type: widget.expense.type,
                ),
              );
            } else if (state is ExpenseFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ExpenseLoading;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3, // مثل LegalNewsScreen
                      decoration:
                      const InputDecoration(labelText: 'Description'),
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Amount'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (double.tryParse(value) == null) return 'Invalid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _onUpdatePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                      ),
                      child: const Text(
                        'Update',
                        style:
                        TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
