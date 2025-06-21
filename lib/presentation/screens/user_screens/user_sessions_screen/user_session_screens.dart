import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../../blocs/sessions_bloc/sessions_event.dart';
import '../../../../constant.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/refresh_button.dart';
import '../../../widgets/sessions_list.dart';

class UserSessionScreens extends StatefulWidget {
  const UserSessionScreens({super.key});

  @override
  State<UserSessionScreens> createState() => _UserSessionScreensState();
}

class _UserSessionScreensState extends State<UserSessionScreens> {
  late SessionsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SessionsBloc>(context);
    bloc.add(
      GetClientSessionsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Client Sessions',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SessionsList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(
            GetClientSessionsEvent(),
          );
        },
      ),
    );
  }
}
