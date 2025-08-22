import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/payroll_bloc/payroll_bloc.dart';
import '../../blocs/payroll_bloc/payroll_event.dart';

import '../../data/models/payroll_model.dart';
import 'payroll_item.dart';

class PayrollList extends StatefulWidget {
  const PayrollList({super.key, required this.bloc});
  final PayrollBloc bloc;

  @override
  State<PayrollList> createState() => _PayrollListState();
}

class _PayrollListState extends State<PayrollList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllPayrollsEvent());
  }

  List<PayrollModel> payrollList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayrollBloc, PayrollState>(
      listener: (context, state) {
        if (state is PayrollSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllPayrollsEvent());
        } else if (state is PayrollFail) {
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
      child: BlocBuilder<PayrollBloc, PayrollState>(
        builder: (context, state) {
          if (state is PayrollListLoaded) {
            payrollList = state.list;
            if (payrollList.isEmpty) {
              return const Center(child: Text('There are no payrolls'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: payrollList.length,
                itemBuilder: (context, index) {
                  return PayrollItem(payrollModel: payrollList[index]);
                },
              ),
            );
          } else if (state is PayrollFail) {
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
