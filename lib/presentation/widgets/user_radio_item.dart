import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import 'custom_user_item.dart';

class UserRadioItem extends StatefulWidget {
  const UserRadioItem({
    super.key,
    required this.userModel,
    required this.groupValue,
    required this.onChanged,
    this.subtitle,
  });

  final UserModel userModel;
  final int? groupValue;
  final void Function(int?) onChanged;
  final Widget? subtitle;

  @override
  State<UserRadioItem> createState() => _UserRadioItemState();
}

class _UserRadioItemState extends State<UserRadioItem> {
  @override
  Widget build(BuildContext context) {
    return CustomUserItem(
      userModel: widget.userModel,
      subtitle: widget.subtitle,
      trailing: Radio<int>(
        value: widget.userModel.id,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
