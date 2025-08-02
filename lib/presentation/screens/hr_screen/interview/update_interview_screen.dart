import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/interview_bloc/interview_event.dart';
import '../../../../blocs/interview_bloc/interviews_state.dart';
import '../../../../data/models/interview_model.dart';
import '../../../../themes.dart';

class UpdateInterviewScreen extends StatefulWidget {
  final InterviewModel interview;

  const UpdateInterviewScreen({super.key, required this.interview});

  @override
  State<UpdateInterviewScreen> createState() => _UpdateInterviewScreenState();
}

class _UpdateInterviewScreenState extends State<UpdateInterviewScreen> {
  late DateTime selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.interview.date;
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
      create: (_) => InterviewBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Interview Date'),
          backgroundColor: AppColors.darkBlue,
        ),
        body: BlocConsumer<InterviewBloc, InterviewState>(
          listener: (context, state) {
            if (state is InterviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );
              Navigator.pop(
                context,

              );
            } else if (state is InterviewFail) {
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
                    'Interview ID: ${widget.interview.id}',
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
                  state is InterviewLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<InterviewBloc>(context).add(
                        UpdateInterviewEvent(
                          interviewId: widget.interview.id,
                          date: selectedDate.toIso8601String(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
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
