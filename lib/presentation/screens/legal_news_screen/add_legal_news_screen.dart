import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../../blocs/legal_news_bloc/legal_news_state.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddLegalNewsScreen extends StatefulWidget {
  const AddLegalNewsScreen({super.key});

  @override
  State<AddLegalNewsScreen> createState() => _AddLegalNewsScreenState();
}

class _AddLegalNewsScreenState extends State<AddLegalNewsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar:CustomActionAppBar(
          title: "Add Legal News"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<LegalNewsBloc, LegalNewsState>(
          listener: (context, state) {
            if (state is LegalNewsSuccess) {
              _titleController.clear();
              _descriptionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is LegalNewsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errMsg}"),
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
                      "Create New Legal News",
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
                    state is LegalNewsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          BlocProvider.of<LegalNewsBloc>(context).add(
                            AddLegalNewsEvent(
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
