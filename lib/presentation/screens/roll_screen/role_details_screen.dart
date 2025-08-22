import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/role_bloc/role_bloc.dart';
import '../../../blocs/role_bloc/role_event.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../data/models/role_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/user_item.dart';

class RoleDetailsScreen extends StatefulWidget {
  final RoleModel roleModel;

  const RoleDetailsScreen({super.key, required this.roleModel});

  @override
  State<RoleDetailsScreen> createState() => _RoleDetailsScreenState();
}

class _RoleDetailsScreenState extends State<RoleDetailsScreen> {
  late UserBloc userBloc;

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: valueColor ?? Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();


    BlocProvider.of<RoleBloc>(context).add(
      GetRoleByIdEvent(roleId: widget.roleModel.id),
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

            // قائمة المستخدمين
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
