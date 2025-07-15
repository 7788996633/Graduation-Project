import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../blocs/permission_bloc/permission_event.dart';

import '../../../data/models/permission_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdatePermissionScreen extends StatefulWidget {
  final PermissionModel permission;

  const UpdatePermissionScreen({super.key, required this.permission});

  @override
  State<UpdatePermissionScreen> createState() => _UpdatePermissionScreenState();
}

class _UpdatePermissionScreenState extends State<UpdatePermissionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  bool _isSaving = false;
  bool _hasRequestedFetch = false;

  @override
  void initState() {
    super.initState();
    // نهيء الكنترولر بقيمة الاسم الحالي
    _nameController = TextEditingController(text: widget.permission.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid name'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isSaving = true;
        _hasRequestedFetch = false;
      });

      // هنا ترسل حدث التحديث مع الاسم الجديد بدلاً من النقاط
      BlocProvider.of<PermissionBloc>(context).add(
        UpdatePermissionEvent(
          permissionId: widget.permission.id,
          name: name,  // تمرير الاسم الجديد
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(title: 'Update Permission'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<PermissionBloc, PermissionState>(
          listener: (context, state) {
            if (state is PermissionSuccess && !_hasRequestedFetch) {
              _hasRequestedFetch = true;
              BlocProvider.of<PermissionBloc>(context).add(
                GetPermissionByIdEvent(permissionId: widget.permission.id),
              );
            } else if (state is PermissionLoaded) {
              setState(() {
                _isSaving = false;
              });

              Navigator.pop(context, state.permission);
            } else if (state is PermissionFail) {
              setState(() {
                _isSaving = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMsg),
                  backgroundColor: Colors.red,
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Permission Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a permission name';
                      }
                      return null;
                    },
                    enabled: !_isSaving,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _submitUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                      ),
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
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
