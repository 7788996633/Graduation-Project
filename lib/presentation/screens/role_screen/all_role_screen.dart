import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/role_bloc/role_bloc.dart';
import '../../../blocs/role_bloc/role_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/role_list.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/refresh_button.dart';

import 'add_role_screen.dart';

class ListRolesScreen extends StatefulWidget {
  const ListRolesScreen({super.key});

  @override
  State<ListRolesScreen> createState() => _ListRolesScreenState();
}

class _ListRolesScreenState extends State<ListRolesScreen> {
  late RoleBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RoleBloc>(context);
    bloc.add(GetAllRolesEvent());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Roles',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Role',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => RoleBloc(),
                child: const AddRoleScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:

            RoleList(bloc: bloc),

      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllRolesEvent());
        },
      ),
    );
  }
}
