import 'package:flutter/material.dart';
import '../../data/models/user_profile_model.dart';

class CustomUserItem extends StatelessWidget {
  const CustomUserItem({
    super.key,
    required this.userProfileModel,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final UserProfileModel userProfileModel;
  final Widget? subtitle;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userProfileModel.image),
        ),
        title: Text(
          userProfileModel.name,
        ),
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
