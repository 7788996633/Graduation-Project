import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../../../blocs/hiring_requests/hiring_requests_state.dart';

import '../../../widgets/build_custom_appbar_detials.dart';
import '../../../widgets/custom_text_field_add.dart';
import '../../../widgets/elevated_button_submit.dart';

class AddHiringRequestScreen extends StatefulWidget {
  const AddHiringRequestScreen({super.key});

  @override
  State<AddHiringRequestScreen> createState() => _AddHiringRequestScreenState();
}

class _AddHiringRequestScreenState extends State<AddHiringRequestScreen> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _clearFields() {
    _jobTitleController.clear();
    _typeController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Hiring Request"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<HiringRequestsBloc, HiringRequestsState>(
          listener: (context, state) {
            if (state is HiringRequestsSuccess) {
              _clearFields();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successmsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is HiringRequestsFail) {
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
                      "Create New Hiring Request",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _jobTitleController,
                      label: 'Job Title',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _typeController,
                      label: 'Type',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _descriptionController,
                      label: 'Description',
                      maxLines: 5,
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    const SizedBox(height: 30),
                    state is HiringRequestsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          if (_jobTitleController.text.isEmpty ||
                              _typeController.text.isEmpty ||
                              _descriptionController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill in all fields."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          BlocProvider.of<HiringRequestsBloc>(context).add(
                            CreateHiringRequestsEvent(
                              jopTitle: _jobTitleController.text.trim(),
                              type: _typeController.text.trim(),
                              description: _descriptionController.text.trim(),
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
