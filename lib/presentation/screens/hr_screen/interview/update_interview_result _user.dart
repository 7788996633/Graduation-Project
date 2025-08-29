import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/interview_bloc/interview_event.dart';
import '../../../../blocs/interview_bloc/interviews_state.dart';
import '../../../../data/models/interview_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class UpdateInterviewResultScreen extends StatefulWidget {
  final InterviewModel interview;

  const UpdateInterviewResultScreen({super.key, required this.interview});

  @override
  State<UpdateInterviewResultScreen> createState() =>
      _UpdateInterviewResultScreenState();
}

class _UpdateInterviewResultScreenState
    extends State<UpdateInterviewResultScreen> {
  late String selectedResult;
  late InterviewBloc _bloc;

  final List<String> resultOptions = [
    'pending',
    'accepted',
    'rejected',
  ];

  @override
  void initState() {
    super.initState();
    selectedResult = widget.interview.result;
    _bloc = InterviewBloc();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    _bloc.add(UpdateInterviewResultEvent(
      interviewId: widget.interview.id,
      result: selectedResult,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InterviewBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Interview Result'),
        body: BlocConsumer<InterviewBloc, InterviewState>(
          listener: (context, state) {
            if (state is InterviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );

              Navigator.pop(
                context,
                InterviewModel(
                  id: widget.interview.id,
                  note: widget.interview.note,
                  date: widget.interview.date,
                  result: selectedResult,

                  userId: widget.interview.userId, jobAppId:widget.interview.jobAppId , // تحديث النتيجة الجديدة

                ),
              );
            } else if (state is InterviewFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is InterviewLoading;

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
                  ...resultOptions.map((result) {
                    return RadioListTile<String>(
                      title: Text(result[0].toUpperCase() + result.substring(1)),
                      value: result,
                      groupValue: selectedResult,
                      onChanged: isLoading
                          ? null
                          : (value) {
                        setState(() {
                          selectedResult = value!;
                        });
                      },
                    );
                  }).toList(),
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
