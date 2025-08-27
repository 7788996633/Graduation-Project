import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_event.dart';
import '../../../themes.dart';

import '../../widgets/custom_appbar_add.dart';
import '../../widgets/my_complaint_list.dart';

class MyListComplaintsScreen extends StatefulWidget {
  const MyListComplaintsScreen({super.key});

  @override
  State<MyListComplaintsScreen> createState() => _MyListComplaintsScreenState();
}

class _MyListComplaintsScreenState extends State<MyListComplaintsScreen> {
  late ComplaintBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ComplaintBloc>(context);
    bloc.add(GetMyComplaintsEvent());
  }

  Future<void> _onRefresh() async {
    bloc.add(GetMyComplaintsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'My Complaints',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            color: AppColors.darkBlue,
            child: MyComplaintList(bloc: bloc),
          ),
        ),
      ),
    );
  }
}
