import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/salary_adjustments_bloc/salary_adjustments_bloc.dart';
import '../../../blocs/salary_adjustments_bloc/salary_adjustments_event.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddSalaryAdjustmentsScreen extends StatefulWidget {
  final int userId;
  const AddSalaryAdjustmentsScreen({super.key, required this.userId});

  @override
  State<AddSalaryAdjustmentsScreen> createState() =>
      _AddSalaryAdjustmentsScreenState();
}

class _AddSalaryAdjustmentsScreenState
    extends State<AddSalaryAdjustmentsScreen> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Salary Adjustment"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<SalaryAdjustmentsBloc, SalaryAdjustmentsState>(
          listener: (context, state) {
            if (state is SalaryAdjustmentsSuccess) {

              _typeController.clear();
              _reasonController.clear();
              _amountController.clear();
              _dateController.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is SalaryAdjustmentsFail) {
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
                      "Create New Salary Adjustment",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),

                    /// userId

                    const SizedBox(height: 20),

                    /// type (Bonus / Deduction)
                    CustomTextFieldAdd(
                      controller: _typeController,
                      label: 'Type (Bonus / Deduction)',
                    ),
                    const SizedBox(height: 20),

                    /// reason
                    CustomTextFieldAdd(
                      controller: _reasonController,
                      label: 'Reason',
                    ),
                    const SizedBox(height: 20),

                    /// amount
                    CustomTextFieldAdd(
                      controller: _amountController,
                      label: 'Amount',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),

                    /// effective date
                    CustomTextFieldAdd(
                      controller: _dateController,
                      label: 'Effective Date (YYYY-MM-DD)',
                    ),
                    const SizedBox(height: 30),

                    state is SalaryAdjustmentsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          BlocProvider.of<SalaryAdjustmentsBloc>(context)
                              .add(
                            AddSalaryAdjustmentEvent(
                              userId: widget.userId,
                              type: _typeController.text,
                              reason: _reasonController.text,
                              amount:
                                  _amountController.text.trim(),
                              effectiveDate: _dateController.text,
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
