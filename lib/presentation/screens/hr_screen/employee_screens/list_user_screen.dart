import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/user_bloc/user_bloc.dart';
import '../../../../themes.dart';

import '../../../widgets/clients_list1.dart';
import '../../../widgets/custom_appbar_add.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({super.key});

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  late UserBloc bloc;
  int? selectedUserId;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(GetAllClients());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Users',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: () async {
            bloc.add(GetAllClients());
            await Future.delayed(const Duration(seconds: 1));
          },
          child: ClientsList1(
            onUserSelected: (userId) {
              setState(() {
                selectedUserId = userId;
              });
            },
          ),
        ),
      ),
    );
  }
}
