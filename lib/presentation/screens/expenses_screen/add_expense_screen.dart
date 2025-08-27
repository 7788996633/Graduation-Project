import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/expenses_bloc/expanses_event.dart';
import '../../../blocs/expenses_bloc/expanses_state.dart';
import '../../../blocs/expenses_bloc/expenses_bloc.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedType; // حقل النوع الآن

  final List<String> _types = ['case', 'payroll', 'operational', 'other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CustomActionAppBar(
          title: "Add Expense"),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseSuccess) {
              _descriptionController.clear();
              _amountController.clear();
              setState(() {
                _selectedType = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ExpenseFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errMsg}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create New Expense",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),

                    // description
                    CustomTextFieldAdd(
                      controller: _descriptionController,
                      label: 'Description',
                    ),
                    const SizedBox(height: 20),

                    // amount
                    CustomTextFieldAdd(
                      controller: _amountController,
                      label: 'Amount',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),

                    // type (radio)
                    const Text(
                      "Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Column(
                      children: _types.map((type) {
                        return RadioListTile<String>(
                          title: Text(type),
                          value: type,
                          groupValue: _selectedType,
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),

                    state is ExpenseLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          if (_selectedType == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                Text("Please select an expense type."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          BlocProvider.of<ExpenseBloc>(context).add(
                            AddExpenseEvent(
                              description:
                              _descriptionController.text.trim(),
                              amount: double.tryParse(
                                  _amountController.text.trim()) ??
                                  0,
                              type: _selectedType!.trim(),
                            ),
                          );
                        },
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
