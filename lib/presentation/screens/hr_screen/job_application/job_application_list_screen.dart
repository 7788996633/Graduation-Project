import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/job_application_list.dart';
import '../../../widgets/refresh_button.dart';
class ListJobApplicationsScreen extends StatefulWidget {
  final int hiringReqId;

  const ListJobApplicationsScreen({super.key, required this.hiringReqId});

  @override
  State<ListJobApplicationsScreen> createState() =>
      _ListJobApplicationsScreenState();
}

class _ListJobApplicationsScreenState extends State<ListJobApplicationsScreen> {
  late JobApplicationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<JobApplicationBloc>(context);
    bloc.add(GetAllJobApplicationsEvent(hiringReqId: widget.hiringReqId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Job Applications',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            JobApplicationList(bloc: bloc, hiringReqId: widget.hiringReqId,),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllJobApplicationsEvent(hiringReqId: widget.hiringReqId));
        },
      ),
    );
  }
}