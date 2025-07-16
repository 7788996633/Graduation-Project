import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../blocs/employee_bloc/employee_bloc.dart';
import '../../data/models/user_model.dart';
import '../screens/hr_screen/employee_screens/add_employee_screen.dart';
import 'custom_user_item.dart';

class ClientItem1 extends StatefulWidget {
  const ClientItem1({
    super.key,
    required this.userModel,
    this.subtitle,
  });

  final UserModel userModel;
  final Widget? subtitle;

  @override
  State<ClientItem1> createState() => _ClientItem1State();
}

class _ClientItem1State extends State<ClientItem1> {
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
            trailing: Tooltip(
              message: 'Add Employee',
              child: IconButton(
                icon: const Icon(Icons.person_add_alt_1),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => EmployeeBloc(),
                        child: AddEmployeeScreen(userId: widget.userModel.id),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is UserProfileFail) {
          return Text(state.errmsg);
        } else {
          return const SizedBox.shrink(); // Placeholder while loading
        }
      },
    );
  }
}
