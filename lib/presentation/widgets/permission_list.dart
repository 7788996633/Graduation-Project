import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/permission_bloc/permission_bloc.dart';
import '../../blocs/permission_bloc/permission_event.dart';

import '../../data/models/permission_model.dart';
import 'permission_item.dart';

class PermissionList extends StatefulWidget {
  const PermissionList({super.key, required this.bloc});
  final PermissionBloc bloc;

  @override
  State<PermissionList> createState() => _PermissionListState();
}

class _PermissionListState extends State<PermissionList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllPermissionsEvent());
  }

  List<PermissionModel> permissionList = [];

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
          widget.bloc.add(GetAllPermissionsEvent());
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
              return const Center(child: Text('There are no permissions'));
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
