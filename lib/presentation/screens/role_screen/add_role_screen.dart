import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/role_bloc/role_bloc.dart';
import '../../../blocs/role_bloc/role_event.dart';

import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddRoleScreen extends StatefulWidget {
  const AddRoleScreen({super.key});

  @override
  State<AddRoleScreen> createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Role"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<RoleBloc, RoleState>(
          listener: (context, state) {
            if (state is RoleSuccess) {
              _nameController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is RoleFail) {
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
                      "Create New Role",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _nameController,
                      label: 'Name',
                    ),
                    const SizedBox(height: 30),
                    state is RoleLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          if (_nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter a role name."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          BlocProvider.of<RoleBloc>(context).add(
                            AddRoleEvent(name: _nameController.text),
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
