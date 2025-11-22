import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_state.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddIssueRequestScreen extends StatefulWidget {
  const AddIssueRequestScreen({super.key});

  @override
  State<AddIssueRequestScreen> createState() => _AddIssueRequestScreenState();
}

class _AddIssueRequestScreenState extends State<AddIssueRequestScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Issue Request"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<IssueRequestsBloc, IssueRequestsState>(
          listener: (context, state) {
            if (state is IssueRequestsSuccess) {
              _titleController.clear();
              _descriptionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successmsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is IssueRequestsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  "Failed: ${state.errmsg}",
                )),
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
                      "Create New Issue",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _titleController,
                      label: 'Title',
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
                    state is IssueRequestsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: 50,
                            child: CustomElevatedButtonSubmit(
                              label: "Submit",
                              onPressed: () {
                                BlocProvider.of<IssueRequestsBloc>(context).add(
                                  CreateIssueRequestsEvent(
                                    title: _titleController.text,
                                    description: _descriptionController.text,
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
