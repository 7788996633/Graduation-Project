import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/user_model.dart';

import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
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
            trailing: Radio<int>(
              value: widget.userModel.id,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
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
}
