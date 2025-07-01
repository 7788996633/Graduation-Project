import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../blocs/job_application/job_application_state.dart';
import '../../../../constant.dart';
import '../../../../data/models/job_application_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class UpdateJobApplicationScreen extends StatefulWidget {
  final JobApplicationModel jobApplication;

  const UpdateJobApplicationScreen({super.key, required this.jobApplication});

  @override
  State<UpdateJobApplicationScreen> createState() => _UpdateJobApplicationScreenState();
}

class _UpdateJobApplicationScreenState extends State<UpdateJobApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.jobApplication.date;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.isBefore(tomorrow) ? tomorrow : selectedDate,
      firstDate: tomorrow, // يبدأ من بكرا فقط
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Update Job Application',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer< JobApplicationBloc, JobApplicationState>(
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
              Navigator.pop(
                context,
                JobApplicationModel(
                  id: widget.jobApplication.id,
                  result: widget.jobApplication.result,
                  note: widget.jobApplication.note,
                  date: selectedDate,
                  hiringReqId: widget.jobApplication.hiringReqId,
                  userName: '', jobTitle: '', cvLink: '',
                ),
              );
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
            } else if (state is JobApplicationLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Loading ...",
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.grey,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selected Date: ${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<JobApplicationBloc>(context).add(
                        UpdateJobApplicationEvent(
                          jobApplicationId: widget.jobApplication.id,
                          date: selectedDate.toIso8601String(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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