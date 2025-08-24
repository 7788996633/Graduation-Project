import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/salary_adjustments_bloc/salary_adjustments_bloc.dart';
import '../../../blocs/salary_adjustments_bloc/salary_adjustments_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/salary_adjustments_list.dart';

class ListSalaryAdjustmentsScreen extends StatefulWidget {
  final int userId;
  const ListSalaryAdjustmentsScreen({super.key, required this.userId});

  @override
  State<ListSalaryAdjustmentsScreen> createState() =>
      _ListSalaryAdjustmentsScreenState();
}

class _ListSalaryAdjustmentsScreenState
    extends State<ListSalaryAdjustmentsScreen> {
  late SalaryAdjustmentsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SalaryAdjustmentsBloc>(context);
    bloc.add(GetAllSalaryAdjustmentsEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Salary Adjustments',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: SalaryAdjustmentsList(
                bloc: bloc,
                userId: widget.userId,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllSalaryAdjustmentsEvent(userId: widget.userId));
        },
      ),
    );
  }
}
