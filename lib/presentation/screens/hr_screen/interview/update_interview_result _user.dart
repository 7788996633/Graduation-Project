import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/interview_bloc/interview_event.dart';
import '../../../../blocs/interview_bloc/interviews_state.dart';
import '../../../../constant.dart';
import '../../../../data/models/interview_model.dart';
import '../../../widgets/custom_appbar_add.dart';

class UpdateInterviewResultScreen extends StatefulWidget {
  final InterviewModel interview;

  const UpdateInterviewResultScreen({super.key, required this.interview});

  @override
  State<UpdateInterviewResultScreen> createState() => _UpdateInterviewResultScreenState();
}

class _UpdateInterviewResultScreenState extends State<UpdateInterviewResultScreen> {
  final _formKey = GlobalKey<FormState>();
  late String selectedResult;

  @override
  void initState() {
    super.initState();
    selectedResult = widget.interview.result ?? 'pending'; // إذا كانت null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(title: 'Update Interview Result'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<InterviewBloc, InterviewState>(
          listener: (context, state) {
            if (state is InterviewSuccess) {
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
                InterviewModel(
                  id: widget.interview.id,
                  result: selectedResult,
                  note: widget.interview.note,
                  date: widget.interview.date,
                ),
              );
            } else if (state is InterviewFail) {
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
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Interview Result",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedResult,
                    items: const [
                      DropdownMenuItem(value: 'accepted', child: Text('Accepted')),
                      DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
                      DropdownMenuItem(value: 'pending', child: Text('Pending')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedResult = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<InterviewBloc>(context).add(
                        UpdateInterviewResultEvent(
                          interviewId: widget.interview.id,
                          result: selectedResult,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                    ),
                    child: const Text(
                      'Update Result',
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
