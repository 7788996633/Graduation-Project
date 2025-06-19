import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../data/models/permission_model.dart';

class AssignPermissionsScreen extends StatelessWidget {
  final int roleId;

  const AssignPermissionsScreen({super.key, required this.roleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعيين الصلاحيات'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PermissionBloc()
              ..add(GetAllPermissionEvent())
              ..add(GetAllPermissionByRoleIdEvent(RoleId: roleId)),
          ),
        ],
        child: BlocBuilder<PermissionBloc, PermissionState>(
          builder: (context, state) {
            if (state is PermissionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is getAllPermissionsSuccessfully &&
                state is getAllPermissionsByRoleIdSuccessfully) {
              return _buildPermissionsAssignment(
                context,
                state.permissions,
                state.permissions,
              );
            } else if (state is PermissionFail) {
              return Center(child: Text('حدث خطأ: ${state.errmsg}'));
            }
            return const Center(child: Text('جارٍ تحميل البيانات...'));
          },
        ),
      ),
    );
  }

  Widget _buildPermissionsAssignment(
      BuildContext context,
      List<PermissionModel> allPermissions,
      List<PermissionModel> rolePermissions,
      ) {
    final assignedPermissionIds = rolePermissions.map((p) => p.id).toSet();

    return ListView.builder(
      itemCount: allPermissions.length,
      itemBuilder: (context, index) {
        final permission = allPermissions[index];
        final isAssigned = assignedPermissionIds.contains(permission.id);

        return CheckboxListTile(
          title: Text(permission.name),
          value: isAssigned,
          onChanged: (value) {
            context.read<PermissionBloc>().add(
              AssignPermissions(
                RoleId: roleId,
                PermissionsId: permission.id,
              ),
            );
          },
        );
      },
    );
  }
}