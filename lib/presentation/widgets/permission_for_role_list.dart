import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/permission_bloc/permission_bloc.dart';
import '../../blocs/permission_bloc/permission_event.dart';

import '../../data/models/permission_model.dart';
import 'permission_item.dart';

class PermissionForRoleList extends StatefulWidget {
  final PermissionBloc bloc;
  final int roleId; // إضافة roleId كحقل مطلوب

  const PermissionForRoleList({super.key, required this.bloc, required this.roleId});

  @override
  State<PermissionForRoleList> createState() => _PermissionForRoleListState();
}

class _PermissionForRoleListState extends State<PermissionForRoleList> {
  @override
  void initState() {
    super.initState();

    widget.bloc.add(GetPermissionForRoleEvent(roleId: widget.roleId));
  }

  List<PermissionModel> permissionList = [];

  void _refreshPermissions() {
    widget.bloc.add(GetPermissionForRoleEvent(roleId: widget.roleId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PermissionBloc, PermissionState>(
      listener: (context, state) {
        if (state is PermissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          _refreshPermissions(); // تحديث القائمة بعد النجاح
        } else if (state is PermissionFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (state is PermissionListLoaded) {
            permissionList = state.list;
            if (permissionList.isEmpty) {
              return const Center(child: Text('There are no permissions for role'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: permissionList.length,
                itemBuilder: (context, index) {
                  return PermissionItem(permissionModel: permissionList[index]);
                },
              ),
            );
          } else if (state is PermissionFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
