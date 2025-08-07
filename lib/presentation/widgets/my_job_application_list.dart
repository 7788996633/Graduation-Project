import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/job_application/job_application_bloc.dart';
import '../../blocs/job_application/job_application_event.dart';
import '../../blocs/job_application/job_application_state.dart';

import '../../data/models/job_application_model.dart';
import 'job_application_item.dart';

class MyJobApplicationList extends StatefulWidget {
  const MyJobApplicationList({super.key, required this.bloc});
  final JobApplicationBloc bloc;

  @override
  State<MyJobApplicationList> createState() => _MyJobApplicationListState();
}

class _MyJobApplicationListState extends State<MyJobApplicationList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetMyJobApplicationsEvent());
  }

  List<JobApplicationModel> jobApplicationList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobApplicationBloc, JobApplicationState>(
      listener: (context, state) {
        if (state is JobApplicationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetMyJobApplicationsEvent());
        } else if (state is JobApplicationFail) {
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
      child: BlocBuilder<JobApplicationBloc, JobApplicationState>(
        builder: (context, state) {
          if (state is JobApplicationListLoaded) {
            jobApplicationList = state.list;
            if (jobApplicationList.isEmpty) {
              return const Center(child: Text('There are no job applications'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: jobApplicationList.length,
                itemBuilder: (context, index) {
                  return JobApplicationItem(
                    jobApplication: jobApplicationList[index],
                  );
                },
              ),
            );
          } else if (state is JobApplicationFail) {
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
