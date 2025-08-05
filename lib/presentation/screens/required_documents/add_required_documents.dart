import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../blocs/required_document_bloc/required_document_state.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddRequiredDocumentScreen extends StatefulWidget {
  final int issueId;
  const AddRequiredDocumentScreen({super.key, required this.issueId});

  @override
  State<AddRequiredDocumentScreen> createState() =>
      _AddRequiredDocumentScreenState();
}

class _AddRequiredDocumentScreenState extends State<AddRequiredDocumentScreen> {
  final TextEditingController _requireFileTypeController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Add Require Document',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<RequiredDocumentsBloc, RequiredDocumentsState>(
          listener: (context, state) {
            if (state is RequiredDocumentsSuccess) {
              _requireFileTypeController.clear();
              _noteController.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successmsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is RequiredDocumentsFail) {
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
                      "Create New Required Document",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _requireFileTypeController,
                      label: 'Require File Type',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _noteController,
                      label: 'Note',
                    ),
                    const SizedBox(height: 30),
                    state is RequiredDocumentsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 50,
                            child: CustomElevatedButtonSubmit(
                              label: "Submit",
                              onPressed: () {
                                BlocProvider.of<RequiredDocumentsBloc>(context)
                                    .add(
                                  CreateRequiredDocumentsEvent(
                                    issueId: widget.issueId,
                                    requireFileType:
                                        _requireFileTypeController.text,
                                    note: _noteController.text,
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
