import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
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
            subtitle: widget.subtitle,
            trailing: Checkbox(
              value: widget.selected,
              onChanged: widget.onChanged,
            ),
          );
        } else if (state is UserProfileFail) {
          return Text(state.errmsg);
        } else {
          return const SizedBox.shrink(); // Empty widget
        }
      },
    );
  }
}

