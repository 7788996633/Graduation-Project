import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/salary_adjustments_bloc/salary_adjustments_bloc.dart';
import '../../../blocs/salary_adjustments_bloc/salary_adjustments_event.dart';

import '../../../data/models/salary_adjustments_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class SalaryAdjustmentsDetailsScreen extends StatefulWidget {
  final SalaryAdjustment salaryAdjustment;

  const SalaryAdjustmentsDetailsScreen({super.key, required this.salaryAdjustment});

  @override
  State<SalaryAdjustmentsDetailsScreen> createState() => _SalaryAdjustmentsDetailsScreenState();
}

class _SalaryAdjustmentsDetailsScreenState extends State<SalaryAdjustmentsDetailsScreen> {
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

    BlocProvider.of<SalaryAdjustmentsBloc>(context).add(
      GetSalaryAdjustmentByIdEvent(adjustmentId: widget.salaryAdjustment.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Salary Adjustment Details',
      ),
      body: BlocBuilder<SalaryAdjustmentsBloc, SalaryAdjustmentsState>(
        builder: (context, state) {
          if (state is SalaryAdjustmentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SalaryAdjustmentsLoaded) {
            final adjustment = state.adjustment;

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
                          Icons.trending_up_outlined,
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
                      _buildInfoRow('ID', adjustment.id.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Type', adjustment.type),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Amount', adjustment.amount.toString(), valueColor: AppColors.darkBlue),
                      Divider(color: Colors.blueAccent.shade100, thickness: 1.5),
                      _buildInfoRow('Reason', adjustment.reason ?? "-"),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is SalaryAdjustmentsFail) {
            return Center(child: Text('Error: ${state.errMsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
