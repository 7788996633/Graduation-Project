import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/interview_bloc/interview_event.dart';
import '../../../../blocs/interview_bloc/interviews_state.dart';
import '../../../../data/models/interview_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class UpdateInterviewScreen extends StatefulWidget {
  final InterviewModel interview;

  const UpdateInterviewScreen({super.key, required this.interview});

  @override
  State<UpdateInterviewScreen> createState() => _UpdateInterviewScreenState();
}

class _UpdateInterviewScreenState extends State<UpdateInterviewScreen> {
  late TextEditingController _dateController;
  late DateTime selectedDate;
  late InterviewBloc _bloc;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.interview.date;
    _dateController =
        TextEditingController(text: DateFormat('yyyy-MM-dd').format(selectedDate));
    _bloc = InterviewBloc();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _bloc.close();
    super.dispose();
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

  void _onUpdatePressed() {
    _bloc.add(UpdateInterviewEvent(
      interviewId: widget.interview.id,
      date: selectedDate.toIso8601String(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InterviewBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Interview Date'),
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
                    jobAppId: widget.interview.jobAppId,
                    userId: widget.interview.userId,
                    result: '', // أو القيمة الجديدة اللي بدك تحفظها
                    date: selectedDate, // التاريخ الجديد
                    note: widget.interview.note, // إذا عندك ملاحظات
                  )

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
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Interview ID: ${widget.interview.id}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        labelText: 'Select New Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 24),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: _onUpdatePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
