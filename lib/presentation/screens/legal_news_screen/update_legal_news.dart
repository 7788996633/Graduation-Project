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
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late LegalNewsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.legalNews.title);
    _descriptionController =
        TextEditingController(text: widget.legalNews.description);
    _bloc = LegalNewsBloc();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    _bloc.add(UpdateLegalNewsEvent(
      newsId: widget.legalNews.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LegalNewsBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Legal News'),
        body: BlocConsumer<LegalNewsBloc, LegalNewsState>(
          listener: (context, state) {
            if (state is LegalNewsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );

              Navigator.pop(
                context,
                LegalNewsModel(
                  id: widget.legalNews.id,
                  title: _titleController.text.trim(),
                  description: _descriptionController.text.trim(),
                  createdAt: widget.legalNews.createdAt,
                  updatedAt: DateTime.now().toIso8601String(),
                ),
              );
            } else if (state is LegalNewsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LegalNewsLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update News',
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
