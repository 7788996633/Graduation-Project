import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/job_application/job_application_bloc.dart';
import '../../../../blocs/job_application/job_application_event.dart';
import '../../../../blocs/job_application/job_application_state.dart';
import '../../../../data/models/job_application_model.dart';

class UpdateJobApplicationScreen extends StatefulWidget {
  final JobApplicationModel jobApplication;

  const UpdateJobApplicationScreen({super.key, required this.jobApplication});

  @override
  State<UpdateJobApplicationScreen> createState() => _UpdateJobApplicationScreenState();
}

class _UpdateJobApplicationScreenState extends State<UpdateJobApplicationScreen> {
  late DateTime selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.jobApplication.date;
    _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.isBefore(tomorrow) ? tomorrow : selectedDate,
      firstDate: tomorrow,
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JobApplicationBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Job Application Date'),
          backgroundColor: Colors.brown,
        ),
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
                  note: widget.jobApplication.note,
                  date: selectedDate, // التاريخ الجديد اللي اختاره المستخدم
                  hiringReqId: widget.jobApplication.hiringReqId,
                  jobTitle: widget.jobApplication.jobTitle,
                  cvLink: widget.jobApplication.cvLink,
                  userId: widget.jobApplication.userId, userName: '',
                ),
              );
            } else if (state is JobApplicationFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Title: ${widget.jobApplication.jobTitle}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      labelText: 'Select New Date',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  state is JobApplicationLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<JobApplicationBloc>(context).add(
                        UpdateJobApplicationEvent(
                          jobApplicationId: widget.jobApplication.id,
                          date: selectedDate.toIso8601String(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Date',
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
