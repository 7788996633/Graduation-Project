import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../blocs/role_bloc/role_bloc.dart';
import '../../../blocs/role_bloc/role_event.dart';
import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/permission_for_role_list.dart';
import '../../widgets/user_item.dart';

class RoleDetailsScreen extends StatefulWidget {
  final dynamic roleModel; // استبدل dynamic بالنوع الصحيح إذا موجود
  const RoleDetailsScreen({super.key, required this.roleModel});

  @override
  State<RoleDetailsScreen> createState() => _RoleDetailsScreenState();
}

class _RoleDetailsScreenState extends State<RoleDetailsScreen> {
  late UserBloc userBloc;
  late PermissionBloc permissionBloc;

  @override
  void initState() {
    super.initState();

    // طلب بيانات الدور
    BlocProvider.of<RoleBloc>(context).add(
      GetRoleByIdEvent(roleId: widget.roleModel.id),
    );

    // تهيئة bloc للصلاحيات
    permissionBloc = PermissionBloc();
  }

  Widget _buildInfoRow(String title, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // مهم للنصوص الطويلة
        children: [
          SizedBox(
            width: 120, // عرض ثابت للعنوان
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Role Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تفاصيل الدور
            Card(
              elevation: 12,
              shadowColor: Colors.deepPurple.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 80,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInfoRow('Role Name', widget.roleModel.name),
                    Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                    _buildInfoRow('Description', widget.roleModel.description,
                        valueColor: AppColors.darkBlue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // زر عرض الصلاحيات المرتبطة بالدور
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: BlocProvider.value(
                      value: permissionBloc,
                      child: PermissionForRoleList(
                        bloc: permissionBloc,
                        roleId: widget.roleModel.id,
                      ),
                    ),
                  ),
                );
              },
              child: const Text('عرض الصلاحيات لهذا الدور'),
            ),

            const SizedBox(height: 24),

            // قائمة المستخدمين المرتبطين بالدور
            Text(
              'المستخدمين المرتبطين بهذا الدور:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UsersListLoaded) {
                  final users = state.usersList;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) =>
                        UserItem(userModel: users[index]),
                  );
                } else if (state is UserFail) {
                  return Text(
                    state.errmsg,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
