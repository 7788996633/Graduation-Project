import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddSessionTypeScreen extends StatefulWidget {
  const AddSessionTypeScreen({super.key,});

  @override
  State<AddSessionTypeScreen> createState() => _AddSessionTypeScreenState();
}

class _AddSessionTypeScreenState extends State<AddSessionTypeScreen> {
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CustomActionAppBar(
    title: "Add Session Type"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<SessionTypeBloc, SessionTypeState>(
          listener: (context, state) {
            if (state is SessionTypeSuccess) {
              _typeController.clear();
              _pointsController.clear();
              _descriptionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is SessionTypeFail) {
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
                      "Create New Session Type",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _typeController,
                      label: 'type',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _pointsController,
                      label: 'points',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _descriptionController,
                      label: 'description',
                      maxLines: 5,
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    const SizedBox(height: 30),
                    state is SessionTypeLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          BlocProvider.of<SessionTypeBloc>(context).add(
                            AddSessionTypeEvent(
                              type: _typeController.text,
                              points: int.tryParse(_pointsController.text.trim()) ?? 0,

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
