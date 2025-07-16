import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/presentation/screens/user_screens/user_profile_screens/user_profile_screen.dart';
import '../../themes.dart';

class CustomUserItem extends StatelessWidget {
  const CustomUserItem({
    super.key,
    this.subtitle,
    this.trailing,
    this.onTap,
    required this.userModel,
  });
  final UserModel userModel;
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
              child: UserProfileScreen(
                userId: userModel.id,
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25,
          ),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(userModel.profileModel.image),
          ),
          title: Text(
            userModel.name,
            style: TextStyle(
              color: getCurrentTheme()['BoldText'],
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: subtitle,
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
