import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_event.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_state.dart';

import '../../../constant.dart';
import '../../../data/models/common _consultation_model.dart';


import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateCommonConsultationScreen extends StatefulWidget {
  final CommonConsultationModel consultation;

  const UpdateCommonConsultationScreen({super.key, required this.consultation});

  @override
  State<UpdateCommonConsultationScreen> createState() => _UpdateCommonConsultationScreenState();
}

class _UpdateCommonConsultationScreenState extends State<UpdateCommonConsultationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _answerController;

  bool _isSaving = false;
  bool _hasRequestedFetch = false;

  @override
  void initState() {
    super.initState();
    _answerController = TextEditingController(text: widget.consultation.answer);
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
        _hasRequestedFetch = false;
      });

      BlocProvider.of<CommonConsultationBloc>(context).add(
        UpdateCommonConsultationEvent(
          id: widget.consultation.id,
          answer: _answerController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Update Consultation Answer',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<CommonConsultationBloc, CommonConsultationState>(
          listener: (context, state) {
            if (state is CommonConsultationSuccess && !_hasRequestedFetch) {
              _hasRequestedFetch = true;
              BlocProvider.of<CommonConsultationBloc>(context).add(
                GetCommonConsultationById(id: widget.consultation.id),
              );
            } else if (state is CommonConsultationLoadedSuccessfully) {
              setState(() {
                _isSaving = false;
              });

              Navigator.pop(
                context,
                state.consultationModel,
              );
            } else if (state is CommonConsultationFail) {
              setState(() {
                _isSaving = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errmsg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _answerController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Answer',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter answer' : null,
                    enabled: !_isSaving,
                    maxLines: null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _submitUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                      ),
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
