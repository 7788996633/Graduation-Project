import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/user_bloc/user_bloc.dart';
import '../../../../constant.dart';
import '../../../widgets/users_list.dart';

class ModifyUsersPermissionsScreen extends StatefulWidget {
  const ModifyUsersPermissionsScreen({super.key});

  @override
  State<ModifyUsersPermissionsScreen> createState() =>
      _ModifyUsersPermissionsScreenState();
}

class _ModifyUsersPermissionsScreenState
    extends State<ModifyUsersPermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Users',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => UserBloc(),
                  child: const UsersList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
