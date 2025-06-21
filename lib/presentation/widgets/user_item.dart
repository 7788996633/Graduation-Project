import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import 'custom_user_item.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(
      ShowUserProfileByIdEvent(userId: widget.userModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoadedSuccessfully) {
          return CustomUserItem(
            userProfileModel: state.userProfileModel,
            subtitle: Text(
              widget.userModel.roleName,
            ),
            trailing: widget.userModel.id == 1
                ? const Text("")
                : PopupMenuButton<String>(
                    onSelected: (value) async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirm Role Change"),
                          content: Text(
                              "Are you sure you want to change the role to '$value'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Confirm"),
                            ),
                          ],
                        ),
                      );

                      // التأكد إذا كان الـ context لسه موجود
                      if (!context.mounted) return;

                      if (confirmed == true) {
                        if (value == 'Delete') {
                          BlocProvider.of<UserBloc>(context).add(
                            DeleteUserById(userId: widget.userModel.id),
                          );
                        } else {
                          BlocProvider.of<UserBloc>(context).add(
                            ChangeUserRole(
                              userId: widget.userModel.id,
                              role: value.toLowerCase(),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    itemBuilder: (context) =>
                        getPopupItems(widget.userModel.roleName),
                  ),
          );
        } else if (state is UserProfileFail) {
          return Text(state.errmsg);
        } else {
          return const Text("");
        }
      },
    );
  }

  List<PopupMenuEntry<String>> getPopupItems(String currentRole) {
    final roleOptions = <String, PopupMenuItem<String>>{
      'Lawyer': const PopupMenuItem<String>(
        value: 'Lawyer',
        child: Text("Change Role To Lawyer",
            style: TextStyle(color: Colors.brown)),
      ),
      'Intern': const PopupMenuItem<String>(
        value: 'Intern',
        child: Text("Change Role To Intern",
            style: TextStyle(color: Colors.orange)),
      ),
      'HR': const PopupMenuItem<String>(
        value: 'HR',
        child: Text("Change Role To HR",
            style: TextStyle(color: Colors.yellowAccent)),
      ),
      'Accountant': const PopupMenuItem<String>(
        value: 'Accountant',
        child: Text("Change Role To Accountant",
            style: TextStyle(color: Colors.green)),
      ),
      'User': const PopupMenuItem<String>(
        value: 'User',
        child: Text("Change Role To User",
            style: TextStyle(color: Colors.blueGrey)),
      ),
      'Admin': const PopupMenuItem<String>(
        value: 'Admin',
        child: Text(
          "You are the admin",
          style: TextStyle(
            color: Color.fromARGB(255, 179, 34, 106),
          ),
        ),
      ),
      'Delete': const PopupMenuItem<String>(
        value: 'Delete',
        child: Text(
          "Delete this user",
          style: TextStyle(
            color: Color.fromARGB(255, 179, 34, 106),
          ),
        ),
      ),
    };

    final current = currentRole.toUpperCase();

    if (current == 'ADMIN') {
      return [roleOptions['Admin']!];
    }

    final allowedTransitions = <String, List<String>>{
      'LAWYER': ['User'],
      'INTERN': ['Lawyer', 'User'],
      'HR': ['User'],
      'ACCOUNTANT': ['User'],
      'USER': ['Lawyer', 'Intern', 'HR', 'Accountant'],
    };

    final allowed = allowedTransitions[current];
    if (allowed == null) return [];

    return allowed.map((r) => roleOptions[r]!).toList();
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
