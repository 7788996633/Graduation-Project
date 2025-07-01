import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../../../data/models/issue_request_model.dart';

class UpdateIssueRequestScreen extends StatefulWidget {
  final IssueRequestModel issueRequest;

  const UpdateIssueRequestScreen({super.key, required this.issueRequest});

  @override
  State<UpdateIssueRequestScreen> createState() =>
      _UpdateIssueRequestScreenState();
}

class _UpdateIssueRequestScreenState extends State<UpdateIssueRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.issueRequest.title);
    _descriptionController =
        TextEditingController(text: widget.issueRequest.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<IssueRequestsBloc>(context).add(
        UpdateIssueRequestEvent(
          issueRequestId: widget.issueRequest.id,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Issue Request'),
        backgroundColor: const Color(0xFFB8820E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitUpdate,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F6829)),
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
