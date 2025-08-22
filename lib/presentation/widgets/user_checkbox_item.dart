import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import 'custom_user_item.dart';

class UserCheckboxItem extends StatefulWidget {
  const UserCheckboxItem({
    super.key,
    required this.userModel,
    required this.selected,
    required this.onChanged,
    this.subtitle,
  });

  final UserModel userModel;
  final bool selected;
  final void Function(bool?) onChanged;
  final Widget? subtitle;

  @override
  State<UserCheckboxItem> createState() => _UserCheckboxItemState();
}

class _UserCheckboxItemState extends State<UserCheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return CustomUserItem(
      userModel: widget.userModel,
      subtitle: widget.subtitle,
      trailing: Checkbox(
        value: widget.selected,
        onChanged: widget.onChanged,
      ),
    );
  }
}
