import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/salary_adjustments_bloc/salary_adjustments_bloc.dart';
import '../../blocs/salary_adjustments_bloc/salary_adjustments_event.dart';

import '../../data/models/salary_adjustments_model.dart';
import 'salary_adjustments_item.dart';

class SalaryAdjustmentsList extends StatefulWidget {
 final int userId;
  const SalaryAdjustmentsList({super.key, required this.bloc,required this.userId});
  final SalaryAdjustmentsBloc bloc;

  @override
  State<SalaryAdjustmentsList> createState() => _SalaryAdjustmentsListState();
}

class _SalaryAdjustmentsListState extends State<SalaryAdjustmentsList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllSalaryAdjustmentsEvent(userId: widget.userId));
  }

  List<SalaryAdjustment> salaryAdjustmentsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SalaryAdjustmentsBloc, SalaryAdjustmentsState>(
      listener: (context, state) {
        if (state is SalaryAdjustmentsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
        return widget.bloc.add(GetAllSalaryAdjustmentsEvent(userId: widget.userId));
        } else if (state is SalaryAdjustmentsFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<SalaryAdjustmentsBloc, SalaryAdjustmentsState>(
        builder: (context, state) {
          if (state is SalaryAdjustmentsListLoaded) {
            salaryAdjustmentsList = state.list;
            print('===============================sz $salaryAdjustmentsList');

            if (salaryAdjustmentsList.isEmpty) {
              return const Center(child: Text('There are no salary adjustments'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: salaryAdjustmentsList.length,
                itemBuilder: (context, index) {
                  return SalaryAdjustmentsItem(
                    salaryAdjustmentsModel: salaryAdjustmentsList[index],
                  );
                },
              ),
            );
          } else if (state is SalaryAdjustmentsFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
