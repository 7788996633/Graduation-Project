import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permission_bloc/permission_bloc.dart';

class RolesScreen extends StatelessWidget {
  const RolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الأدوار'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRoleDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (state is RoleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoleFail) {
            return Center(child: Text('حدث خطأ: ${state.errmsg}'));
          }
          // TODO: Add roles list builder
          return const Center(child: Text('قائمة الأدوار ستظهر هنا'));
        },
      ),
    );
  }

  void _showAddRoleDialog(BuildContext context) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة دور جديد'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'اسم الدور'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PermissionBloc>().add(
                  AddNewRoleEvent(name: nameController.text),
                );
                Navigator.pop(context);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}