import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation/data/models/permission_model.dart';

import '../../../blocs/permission_bloc/permission_bloc.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الصلاحيات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPermissionDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (state is PermissionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is getAllPermissionsSuccessfully) {
            return _buildPermissionsList(state.permissions);
          } else if (state is PermissionFail) {
            return Center(child: Text('حدث خطأ: ${state.errmsg}'));
          } else {
            return const Center(child: Text('لا توجد بيانات'));
          }
        },
      ),
    );
  }

  Widget _buildPermissionsList(List<PermissionModel> permissions) {
    return ListView.builder(
      itemCount: permissions.length,
      itemBuilder: (context, index) {
        final permission = permissions[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(permission.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deletePermission(context, permission.id),
            ),
          ),
        );
      },
    );
  }

  void _showAddPermissionDialog(BuildContext context) {
    final nameController = TextEditingController();
    final roleIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة صلاحية جديدة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'اسم الصلاحية'),
              ),
              TextField(
                controller: roleIdController,
                decoration: const InputDecoration(labelText: 'معرف الدور'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PermissionBloc>().add(
                  AddPermissionEvent(
                    name: nameController.text,
                    RoleId: int.parse(roleIdController.text),
                  ),
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

  void _deletePermission(BuildContext context, int permissionId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('حذف الصلاحية'),
          content: const Text('هل أنت متأكد من حذف هذه الصلاحية؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add delete permission event
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}