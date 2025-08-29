import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../blocs/job_application/job_application_state.dart';
import '../../../../data/models/job_application_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class UpdateJobApplicationScreen extends StatefulWidget {
  final JobApplicationModel jobApplication;

  const UpdateJobApplicationScreen({super.key, required this.jobApplication});

  @override
  State<UpdateJobApplicationScreen> createState() =>
      _UpdateJobApplicationScreenState();
}

class _UpdateJobApplicationScreenState extends State<UpdateJobApplicationScreen> {
  late String selectedStatus;
  late JobApplicationBloc _bloc;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.jobApplication.status;
    _bloc = JobApplicationBloc();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    _bloc.add(UpdateJobApplicationEvent(
      jobApplicationId: widget.jobApplication.id,
      status: selectedStatus,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobApplicationBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Application Status'),
        body: BlocConsumer<JobApplicationBloc, JobApplicationState>(
          listener: (context, state) {
            if (state is JobApplicationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );

              Navigator.pop(
                context,
                JobApplicationModel(
                  id: widget.jobApplication.id,
                  result: widget.jobApplication.result,
                  date: widget.jobApplication.date,
                  cvLink: widget.jobApplication.cvLink,
                  userId: widget.jobApplication.userId,
                  userName: widget.jobApplication.userName,
                  status: selectedStatus, // هنا ترجع الحالة الجديدة
                  submittedAt: widget.jobApplication.submittedAt, hiringRequestId: widget.jobApplication.hiringRequestId, 
                ),
              );
            } else if (state is JobApplicationFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is JobApplicationLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Current Status: ${widget.jobApplication.status}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  RadioListTile<String>(
                    title: const Text('Pending'),
                    value: 'pending',
                    groupValue: selectedStatus,
                    onChanged: isLoading
                        ? null
                        : (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('accepted'),
                    value: 'accepted',
                    groupValue: selectedStatus,
                    onChanged: isLoading
                        ? null
                        : (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('rejected'),
                    value: 'rejected',
                    groupValue: selectedStatus,
                    onChanged: isLoading
                        ? null
                        : (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Status',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
