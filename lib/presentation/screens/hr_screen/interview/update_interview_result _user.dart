import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/interview_bloc/interview_event.dart';
import '../../../../blocs/interview_bloc/interviews_state.dart';
import '../../../../data/models/interview_model.dart';

class UpdateInterviewResultScreen extends StatefulWidget {
  final InterviewModel interview;

  const UpdateInterviewResultScreen({super.key, required this.interview});

  @override
  State<UpdateInterviewResultScreen> createState() =>
      _UpdateInterviewResultScreenState();
}

class _UpdateInterviewResultScreenState
    extends State<UpdateInterviewResultScreen> {
  String? selectedResult;

  final List<String> resultOptions = [
    'accepted',
    'rejected',
    'pending',
  ];

  @override
  void initState() {
    super.initState();
    selectedResult = widget.interview.result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InterviewBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Interview Result'),
          backgroundColor: Colors.indigo,
        ),
        body: BlocConsumer<InterviewBloc, InterviewState>(
          listener: (context, state) {
            if (state is InterviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );
              Navigator.pop(context);
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
                    'Interview Date: ${widget.interview.date.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Current Note: ${widget.interview.note}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: selectedResult,
                    items: resultOptions.map((String result) {
                      return DropdownMenuItem<String>(
                        value: result,
                        child: Text(
                          result[0].toUpperCase() + result.substring(1),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedResult = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select New Result',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  state is InterviewLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      if (selectedResult != null) {
                        BlocProvider.of<InterviewBloc>(context).add(
                          UpdateInterviewResultEvent(
                            interviewId: widget.interview.id,
                            result: selectedResult!,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Result',
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
