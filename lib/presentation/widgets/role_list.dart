import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/role_bloc/role_bloc.dart';
import '../../blocs/role_bloc/role_event.dart';

import '../../data/models/role_model.dart';
import 'role_item.dart';

class RoleList extends StatefulWidget {
  const RoleList({super.key, required this.bloc});
  final RoleBloc bloc;

  @override
  State<RoleList> createState() => _RoleListState();
}

class _RoleListState extends State<RoleList> {
  List<RoleModel> roleList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllRolesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoleBloc, RoleState>(
      listener: (context, state) {
        if (state is RoleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllRolesEvent());
        } else if (state is RoleFail) {
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
      child: BlocBuilder<RoleBloc, RoleState>(
        builder: (context, state) {
          if (state is RoleListLoaded) {
            roleList = state.list;
            if (roleList.isEmpty) {
              return const Center(child: Text('There are no roles'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: roleList.length,
                itemBuilder: (context, index) {
                  return RoleItem(roleModel: roleList[index]);
                },
              ),
            );
          } else if (state is RoleFail) {
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
