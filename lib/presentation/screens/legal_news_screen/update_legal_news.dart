import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../../blocs/legal_news_bloc/legal_news_state.dart';
import '../../../data/models/legal_news_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateLegalNewsScreen extends StatefulWidget {
  final LegalNewsModel legalNews;

  const UpdateLegalNewsScreen({super.key, required this.legalNews});

  @override
  State<UpdateLegalNewsScreen> createState() => _UpdateLegalNewsScreenState();
}

class _UpdateLegalNewsScreenState extends State<UpdateLegalNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  dynamic? _selectedFile; // ممكن تكون File أو Uint8List (للويب)
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.legalNews.title);
    _descriptionController = TextEditingController(text: widget.legalNews.description);
    _fileName = null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        if (kIsWeb) {
          _selectedFile = result.files.single.bytes;
        } else {
          _selectedFile = File(result.files.single.path!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Update Legal News',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<LegalNewsBloc, LegalNewsState>(
          listener: (context, state) {
            if (state is LegalNewsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.successMsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(
                context,
                LegalNewsModel(
                  id: widget.legalNews.id,
                  title: '',
                  description: '',
                  createdAt: '',
                  updatedAt: '',
                ),
              );
            } else if (state is LegalNewsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errMsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is LegalNewsLoading) {
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter title' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter description' : null,
                  ),
                  const SizedBox(height: 20),
                  // زر لاختيار ملف جديد (اختياري)
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.attach_file),
                    label: Text(_fileName ?? 'Choose New File (optional)'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<LegalNewsBloc>(context).add(
                          UpdateLegalNewsEvent(
                            newsId: widget.legalNews.id,
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim(),

                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
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
