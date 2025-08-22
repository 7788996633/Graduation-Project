import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../themes.dart';
import 'custom_user_item.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return CustomUserItem(
      userModel: widget.userModel,
      subtitle: Text(
        style: TextStyle(
          color: getCurrentTheme()['NormalText'],
        ),
        widget.userModel.roleName,
      ),
      trailing: widget.userModel.id == 1
          ? const Text("")
          : PopupMenuButton<String>(
        onSelected: (value) async {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(tr("confirm_role_change")),
              content: Text(
                  tr("are_you_sure_change_role", args: [value])),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(tr("cancel")),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(tr("confirm")),
                ),
              ],
            ),
          );

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
        icon: Icon(
          Icons.settings,
          color: getCurrentTheme()['Icons'],
        ),
        itemBuilder: (context) =>
            getPopupItems(widget.userModel.roleName),
      ),
    );
  }

  List<PopupMenuEntry<String>> getPopupItems(String currentRole) {
    final roleOptions = <String, PopupMenuItem<String>>{
      'Lawyer': PopupMenuItem<String>(
        value: 'Lawyer',
        child: Text(tr("change_role_to_lawyer"),
            style: const TextStyle(color: Colors.brown)),
      ),
      'Intern': PopupMenuItem<String>(
        value: 'Intern',
        child: Text(tr("change_role_to_intern"),
            style: const TextStyle(color: Colors.orange)),
      ),
      'HR': PopupMenuItem<String>(
        value: 'HR',
        child: Text(tr("change_role_to_hr"),
            style: const TextStyle(color: Colors.yellowAccent)),
      ),
      'Accountant': PopupMenuItem<String>(
        value: 'Accountant',
        child: Text(tr("change_role_to_accountant"),
            style: const TextStyle(color: Colors.green)),
      ),
      'User': PopupMenuItem<String>(
        value: 'User',
        child: Text(tr("change_role_to_user"),
            style: const TextStyle(color: Colors.blueGrey)),
      ),
      'Admin': PopupMenuItem<String>(
        value: 'Admin',
        child: Text(
          tr("you_are_admin"),
          style: const TextStyle(
            color: Color.fromARGB(255, 179, 34, 106),
          ),
        ),
      ),
      'Delete': PopupMenuItem<String>(
        value: 'Delete',
        child: Text(
          tr("delete_this_user"),
          style: const TextStyle(
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
}
