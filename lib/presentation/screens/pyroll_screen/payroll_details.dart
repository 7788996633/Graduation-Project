import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/payroll_bloc/payroll_bloc.dart';
import '../../../blocs/payroll_bloc/payroll_event.dart';

import '../../../data/models/payroll_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class PayrollDetailsScreen extends StatefulWidget {
  final PayrollModel payrollModel;

  const PayrollDetailsScreen({super.key, required this.payrollModel});

  @override
  State<PayrollDetailsScreen> createState() => _PayrollDetailsScreenState();
}

class _PayrollDetailsScreenState extends State<PayrollDetailsScreen> {
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: valueColor ?? Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PayrollBloc>(context).add(
      GetPayrollByIdEvent(payrollId: widget.payrollModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Payroll Details',
      ),
      body: BlocBuilder<PayrollBloc, PayrollState>(
        builder: (context, state) {
          if (state is PayrollLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PayrollLoaded) {
            final payroll = state.payroll;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 12,
                shadowColor: Colors.deepPurple.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 80,
                          color: AppColors.darkBlue,
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent.shade200.withOpacity(0.6),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildInfoRow('ID', payroll.id.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Employee ID', payroll.reason),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Amount', payroll.amount.toString(), valueColor: AppColors.darkBlue),
                      Divider(color: Colors.blueAccent.shade100, thickness: 1.5),
                      _buildInfoRow('Description', payroll.type),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is PayrollFail) {
            return Center(child: Text('Error: ${state.errMsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
