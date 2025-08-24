import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_event.dart';
import '../../../themes.dart';

import '../../widgets/custom_appbar_add.dart';
import '../../widgets/my_complaint_list.dart';
import '../../widgets/refresh_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'My Complaints',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MyComplaintList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetMyComplaintsEvent());
        },
      ),
    );
  }
}
