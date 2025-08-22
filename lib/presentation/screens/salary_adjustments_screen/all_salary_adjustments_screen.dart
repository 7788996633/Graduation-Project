import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/salary_adjustments_bloc/salary_adjustments_bloc.dart';
import '../../../blocs/salary_adjustments_bloc/salary_adjustments_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/salary_adjustments_list.dart';
import '../../widgets/custom_search_bar.dart';

import 'add_salary.dart';


class ListSalaryAdjustmentsScreen extends StatefulWidget {
  const ListSalaryAdjustmentsScreen({super.key});

  @override
  State<ListSalaryAdjustmentsScreen> createState() => _ListSalaryAdjustmentsScreenState();
}

class _ListSalaryAdjustmentsScreenState extends State<ListSalaryAdjustmentsScreen> {
  late SalaryAdjustmentsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SalaryAdjustmentsBloc>(context);
    bloc.add(GetAllSalaryAdjustmentsEvent());
  }

  void _onSearch(String type) {
    if (type.trim().isNotEmpty) {
      bloc.add(SearchSalaryAdjustmentsByTypeEvent(type: type));
    } else {
      bloc.add(GetAllSalaryAdjustmentsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Salary Adjustments',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Salary Adjustment',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SalaryAdjustmentsBloc(),
                child: const AddSalaryAdjustmentsScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(
              hint: 'Search by Type',
              onSearch: _onSearch,
            ),
            const SizedBox(height: 20),
            SalaryAdjustmentsList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllSalaryAdjustmentsEvent());
        },
      ),
    );
  }
}