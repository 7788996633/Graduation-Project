import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_event.dart';
import '../../../blocs/legal_books_bloc/legal_books_state.dart';
import '../../../themes.dart';

class AddLegalBookScreen extends StatefulWidget {
  const AddLegalBookScreen({super.key});

  @override
  State<AddLegalBookScreen> createState() => _AddLegalBookScreenState();
}

class _AddLegalBookScreenState extends State<AddLegalBookScreen> {
  dynamic selectedFile;
  String? fileName;
  String bookTitle = '';

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;

        if (kIsWeb) {
          selectedFile = result.files.single.bytes; // Uint8List
        } else {
          selectedFile = File(result.files.single.path!); // File
        }
      });
    }
  }

  void submit() {
    if (selectedFile == null || fileName == null || bookTitle.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter book title and select a file')),
      );
      return;
    }

    BlocProvider.of<LegalBookBloc>(context).add(
      AddLegalBookEvent(
        file: selectedFile,
        bookTitle: bookTitle.trim(),
        fileName: fileName!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final content = SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: BlocConsumer<LegalBookBloc, LegalBookState>(
        listener: (context, state) {
          if (state is LegalBookSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMsg)),
            );
            Navigator.pop(context);
          } else if (state is LegalBookFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMsg)),
            );
          }
        },
        builder: (context, state) {
          if (state is LegalBookLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final innerContent = Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Legal Book',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Book Title',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => setState(() => bookTitle = val),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(LucideIcons.uploadCloud, color: Colors.white),
                  onPressed: pickFile,
                  label: Text(
                    fileName ?? 'Choose File',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: submit,
                  label: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );

          if (kIsWeb) {
            return Center(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  width: 490,         // العرض ثابت
                  height: 500,        // الطول ثابت
                  padding: const EdgeInsets.all(9),
                  child: Center(
                    child: SingleChildScrollView(
                      child: innerContent,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return innerContent;
          }
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Legal Book',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: content,
      ),
    );
  }
}
