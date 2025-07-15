import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../blocs/required_document_bloc/required_document_state.dart';

import '../../../data/models/required_document_model.dart';

class UpdateRequiredDocumentScreen extends StatefulWidget {
  final RequiredDocumentModel requiredDocument;

  const UpdateRequiredDocumentScreen({super.key, required this.requiredDocument});

  @override
  State<UpdateRequiredDocumentScreen> createState() =>
      _UpdateRequiredDocumentScreenState();
}

class _UpdateRequiredDocumentScreenState extends State<UpdateRequiredDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _noteController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.requiredDocument.note);
   _statusController = TextEditingController(text: widget.requiredDocument.note);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Required Document'),
        backgroundColor: const Color(0xFFB8820E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<RequiredDocumentsBloc, RequiredDocumentsState>(
          listener: (context, state) {
            if (state is RequiredDocumentsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.successmsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is RequiredDocumentsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errmsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is RequiredDocumentsLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Loading ...",
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.grey,
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
                    controller: _noteController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Note'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a note' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _statusController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Status'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter a status' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<RequiredDocumentsBloc>(context).add(
                          UpdateRequiredDocumentsEvent(
                            requiredDocumentId: widget.requiredDocument.id,
                            note: _noteController.text.trim(),
                            status: _statusController.text.trim(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F6829),
                    ),
                    child: const Text('Update'),
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
