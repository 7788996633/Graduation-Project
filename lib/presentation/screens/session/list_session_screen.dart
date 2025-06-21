import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_event.dart';
import '../../../constant.dart';

import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/sessions_list.dart';
import 'create_session.dart';

class ListSessionsScreen extends StatefulWidget {
  const ListSessionsScreen({super.key, required this.issueId});
  final int issueId;
  @override
  State<ListSessionsScreen> createState() => _ListSessionsScreenState();
}

class _ListSessionsScreenState extends State<ListSessionsScreen> {
  late SessionsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SessionsBloc>(context);
    bloc.add(
      GetAllSessionsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Sessions',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Sessions',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionsBloc(),
                child: CreateSessionScreen(
                  issueId: widget.issueId,
                ),
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
            SessionsList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(
            GetAllSessionsEvent(),
          );
        },
      ),
    );
  }
}
