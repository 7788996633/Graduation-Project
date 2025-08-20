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
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _dateController;
  late DateTime selectedDate;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.interview.date;
    _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(selectedDate));
  }

  @override
  void dispose() {
    _dateController.dispose();
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

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
      });

      BlocProvider.of<InterviewBloc>(context).add(
        UpdateInterviewEvent(
          interviewId: widget.interview.id,
          date: selectedDate.toIso8601String(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomActionAppBar(title: 'Update Interview Date'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<InterviewBloc, InterviewState>(
          listener: (context, state) {
            if (state is InterviewSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMsg),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is InterviewFail) {
              setState(() {
                _isSaving = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMsg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                    enabled: !_isSaving,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _submitUpdate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
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
            );
          },
        ),
      ),
    );
  }
}
