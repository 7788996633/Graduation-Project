import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../../blocs/sessions_bloc/sessions_event.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/refresh_button.dart';
import '../../../widgets/sessions_list.dart';

class LawyerSessionsScreen extends StatefulWidget {
  const LawyerSessionsScreen({super.key});

  @override
  State<LawyerSessionsScreen> createState() => _LawyerSessionsScreenState();
}

class _LawyerSessionsScreenState extends State<LawyerSessionsScreen> {
  late SessionsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SessionsBloc>(context);
    bloc.add(
      GetLawyerSessionsEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Lawyer Sessions',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SessionsList(
              bloc: bloc,
              issueId: null,
            ),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(
            GetLawyerSessionsEvent(),
          );
        },
      ),
    );
  }
}
