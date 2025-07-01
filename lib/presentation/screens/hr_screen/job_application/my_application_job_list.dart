import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../constant.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/job_application_list.dart';
import '../../../widgets/refresh_button.dart';

class  MyListJobApplicationsScreen extends StatefulWidget {
  const MyListJobApplicationsScreen({super.key});

  @override
  State<MyListJobApplicationsScreen> createState() => _MyListJobApplicationsScreenState();
}

class _MyListJobApplicationsScreenState extends State<MyListJobApplicationsScreen> {
  late JobApplicationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<JobApplicationBloc>(context);
    bloc.add(GetMyJobApplicationsEvent()); // 👈 استبدال All بـ My
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'My Job Applications', // 👈 التعديل في العنوان
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            JobApplicationList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetMyJobApplicationsEvent()); // 👈 استبدال All بـ My
        },
      ),
    );
  }
}
