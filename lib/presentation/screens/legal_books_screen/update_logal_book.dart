import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_event.dart';
import '../../../blocs/legal_books_bloc/legal_books_state.dart';
import '../../../data/models/legal_book_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateLegalBookScreen extends StatefulWidget {
  final LegalBookModel legalBook;

  const UpdateLegalBookScreen({super.key, required this.legalBook});

  @override
  State<UpdateLegalBookScreen> createState() => _UpdateLegalBookScreenState();
}

class _UpdateLegalBookScreenState extends State<UpdateLegalBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _bookTitleController;

  dynamic? _selectedFile; // ممكن تكون File أو Uint8List (للويب)
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _bookTitleController = TextEditingController(text: widget.legalBook.bookTitle);
    _fileName = null; // لحتى نعرف إذا اختار المستخدم ملف جديد أو لا
  }

  @override
  void dispose() {
    _bookTitleController.dispose();
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
        title: 'Update Legal Book',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<LegalBookBloc, LegalBookState>(
          listener: (context, state) {
            if (state is LegalBookSuccess) {
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
                LegalBookModel(
                  id: widget.legalBook.id,
                  bookTitle: '', book: '', createdAt: '', updatedAt: '',
                ),
              );
            } else if (state is LegalBookFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errMsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is LegalBookLoading) {
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
                    controller: _bookTitleController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Book Title'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter book title' : null,
                  ),
                  const SizedBox(height: 20),

                  // زر لاختيار ملف جديد
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.attach_file),
                    label: Text(_fileName ?? 'Choose New File (optional)'),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<LegalBookBloc>(context).add(
                          UpdateLegalBookEvent(
                            bookId: widget.legalBook.id!,
                            file: _selectedFile, // ممكن يكون null
                            bookTitle: _bookTitleController.text.trim(),
                            fileName: _fileName ?? '', // إذا ما اخترنا ملف جديد، ترسل '' أو يمكنك تعديل حسب المنطق
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
