import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/salary_adjustments_bloc/salary_adjustments_bloc.dart';

import '../../data/models/salary_adjustments_model.dart';
import '../../themes.dart';

import '../screens/salary_adjustments_screen/salary_details_screen.dart';

class SalaryAdjustmentsItem extends StatelessWidget {
  const SalaryAdjustmentsItem({super.key, required this.salaryAdjustmentsModel});
  final SalaryAdjustment salaryAdjustmentsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadowColor: AppColors.darkBlue.withOpacity(0.3),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => SalaryAdjustmentsBloc(),
                  child: SalaryAdjustmentsDetailsScreen (
                    salaryAdjustment: salaryAdjustmentsModel,
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
                    "${salaryAdjustmentsModel.type} - ${salaryAdjustmentsModel.amount}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
