import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../blocs/job_application/job_application_state.dart';

import '../../../../themes.dart';
import '../../../../data/models/job_application_model.dart';

import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/job_application_item.dart';

class ListJobApplicationsScreen extends StatefulWidget {
  final int hiringReqId;

  const ListJobApplicationsScreen({super.key, required this.hiringReqId});

  @override
  State<ListJobApplicationsScreen> createState() =>
      _ListJobApplicationsScreenState();
}

class _ListJobApplicationsScreenState
    extends State<ListJobApplicationsScreen> {
  late JobApplicationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<JobApplicationBloc>(context);
    bloc.add(GetAllJobApplicationsEvent(hiringReqId: widget.hiringReqId));
  }

  Future<void> _onRefresh() async {
    bloc.add(GetAllJobApplicationsEvent(hiringReqId: widget.hiringReqId));
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const CustomActionAppBar(
        title: 'Job Applications',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<JobApplicationBloc, JobApplicationState>(
            builder: (context, state) {
              if (state is JobApplicationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is JobApplicationFail) {
                return Center(child: Text(state.errMsg));
              } else if (state is JobApplicationListLoaded) {
                final List<JobApplicationModel> applications =
                    state.list;
                if (applications.isEmpty) {
                  return const Center(child: Text('No Applications Available'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: applications.length,
                  itemBuilder: (context, index) {
                    return JobApplicationItem(
                       jobApplication:applications[index],);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
