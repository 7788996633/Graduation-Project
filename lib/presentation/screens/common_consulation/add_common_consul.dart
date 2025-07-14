import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_event.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_state.dart';

import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddCommonConsultationScreen extends StatefulWidget {
  const AddCommonConsultationScreen({super.key});

  @override
  State<AddCommonConsultationScreen> createState() => _AddCommonConsultationScreenState();
}

class _AddCommonConsultationScreenState extends State<AddCommonConsultationScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar:CustomActionAppBar(
        title: 'Add Common Consultation',),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<CommonConsultationBloc, CommonConsultationState>(
          listener: (context, state) {
            if (state is CommonConsultationSuccess) {
              _questionController.clear();
              _answerController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successmsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is CommonConsultationFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errmsg}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create New Common Consultation",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _questionController,
                      label: 'Question',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _answerController,
                      label: 'Answer',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 30),
                    state is CommonConsultationLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          if (_questionController.text.isEmpty || _answerController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill all fields."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          BlocProvider.of<CommonConsultationBloc>(context).add(
                            CreateCommonConsultationEvent(
                              question: _questionController.text,
                              answer: _answerController.text,
                            ),
                          );
                        },
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
