import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/archive_bloc/archive_bloc.dart';

import '../../../blocs/archive_bloc/archive_event.dart';
import '../../../themes.dart';
import '../../widgets/all_archived_issues_list.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';


class ListArchivedIssuesScreen extends StatefulWidget {
  const ListArchivedIssuesScreen({super.key, });


  @override
  State<ListArchivedIssuesScreen> createState() => _ListArchivedIssuesScreenState();
}

class _ListArchivedIssuesScreenState extends State<ListArchivedIssuesScreen> {
  late ArchiveBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ArchiveBloc>(context);
    bloc.add(GetAllArchivedIssuesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Archived Issues',

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ArchivedIssuesList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllArchivedIssuesEvent());
        },
      ),
    );
  }
}