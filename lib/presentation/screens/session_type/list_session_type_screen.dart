import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';
import '../../../constant.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/session_type_list.dart';

import 'add_session_type.dart';

class ListSessionTypesScreen extends StatefulWidget {
  const ListSessionTypesScreen({super.key});

  @override
  State<ListSessionTypesScreen> createState() => _ListSessionTypesScreenState();
}

class _ListSessionTypesScreenState extends State<ListSessionTypesScreen> {
  late SessionTypeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SessionTypeBloc>(context);
    bloc.add(GetAllSessionTypesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Session Types',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Session Type',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionTypeBloc(),
                child: const AddSessionTypeScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SessionTypeList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllSessionTypesEvent());
        },
      ),
    );
  }
}
