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
  late TextEditingController _titleController;
  dynamic? _selectedFile; // File أو Uint8List (للويب)
  String? _fileName;
  late LegalBookBloc _bloc;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.legalBook.bookTitle);
    _fileName = widget.legalBook.book;
    _bloc = LegalBookBloc();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bloc.close();
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _selectedFile = kIsWeb ? result.files.single.bytes : File(result.files.single.path!);
      });
    }
  }

  void _onUpdatePressed() {
    _bloc.add(UpdateLegalBookEvent(
      bookId: widget.legalBook.id!,
      bookTitle: _titleController.text.trim(),
      file: _selectedFile,
      fileName: _fileName ?? '',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LegalBookBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Legal Book'),
        body: BlocConsumer<LegalBookBloc, LegalBookState>(
          listener: (context, state) {
            if (state is LegalBookSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );

              Navigator.pop(
                context,
                LegalBookModel(
                  id: widget.legalBook.id,
                  bookTitle: _titleController.text.trim(),
                  book: _fileName ?? widget.legalBook.book,
                  createdAt: widget.legalBook.createdAt,
                  updatedAt: DateTime.now().toIso8601String(),
                ),
              );
            } else if (state is LegalBookFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LegalBookLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Book Title'),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton.icon(
                    onPressed: isLoading ? null : _pickFile,
                    icon: const Icon(Icons.attach_file),
                    label: Text(_fileName ?? 'Choose File (optional)'),
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Book',
                      style: TextStyle(color: Colors.white),
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
