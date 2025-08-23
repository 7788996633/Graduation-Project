import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../blocs/permission_bloc/permission_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/permission_for_role_list.dart';
import '../../widgets/permission_list.dart';
import '../../widgets/refresh_button.dart';

import 'add_permission_screen.dart';

class ListPermissionsForRoleScreen extends StatefulWidget {
  final int roleId; // ربط الصلاحيات بدور محدد

  const ListPermissionsForRoleScreen({super.key, required this.roleId});

  @override
  State<ListPermissionsForRoleScreen> createState() => _ListPermissionsForRoleScreenState();
}

class _ListPermissionsForRoleScreenState extends State<ListPermissionsForRoleScreen> {
  late PermissionBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<PermissionBloc>(context);
    // جلب الصلاحيات الخاصة بالدور
    bloc.add(GetPermissionForRoleEvent(roleId: widget.roleId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Permissions for Role', // العنوان الجديد
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            PermissionForRoleList(
              bloc: bloc,
              roleId: widget.roleId,
            ),
            // قائمة الصلاحيات مرتبطة بالـ bloc
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          // تحديث الصلاحيات الخاصة بالدور
          bloc.add(GetPermissionForRoleEvent(roleId: widget.roleId));
        },
      ),
    );
  }
}
