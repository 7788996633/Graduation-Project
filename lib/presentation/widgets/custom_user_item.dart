import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../data/models/user_profile_model.dart';
import '../screens/user_screens/user_profile_screens/user_profile_screen.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => UserProfileBloc(),
              child: UserProfileScreen(userProfileModel: userProfileModel,
              ),
            ),
          ),
        );
      },
      child: Card(
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
      ),
    );
  }
}
