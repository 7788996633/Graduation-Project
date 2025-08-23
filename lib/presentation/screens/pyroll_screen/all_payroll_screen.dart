import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/payroll_bloc/payroll_bloc.dart';
import '../../../blocs/payroll_bloc/payroll_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/payroll_list.dart';
import '../../widgets/custom_search_bar.dart';

import 'add_payroll.dart';

class ListPayrollsScreen extends StatefulWidget {
  const ListPayrollsScreen({super.key});

  @override
  State<ListPayrollsScreen> createState() => _ListPayrollsScreenState();
}

class _ListPayrollsScreenState extends State<ListPayrollsScreen> {
  late PayrollBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PayrollBloc>(context);
    bloc.add(GetAllPayrollsEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Payrolls',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        PayrollList(bloc: bloc),

      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllPayrollsEvent());
        },
      ),
    );
  }
}