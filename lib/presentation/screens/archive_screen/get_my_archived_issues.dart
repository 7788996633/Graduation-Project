import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/archive_bloc/archive_bloc.dart';

import '../../../blocs/archive_bloc/archive_event.dart';
import '../../../themes.dart';

import '../../widgets/custom_appbar_add.dart';

import '../../widgets/my_archived_issues_list.dart';
import '../../widgets/refresh_button.dart';


class ListMyArchivedIssuesScreen extends StatefulWidget {
  const ListMyArchivedIssuesScreen({super.key, });


  @override
  State<ListMyArchivedIssuesScreen> createState() => _ListMyArchivedIssuesScreenState();
}

class _ListMyArchivedIssuesScreenState extends State<ListMyArchivedIssuesScreen> {
  late ArchiveBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ArchiveBloc>(context);
    bloc.add(GetMyArchivedIssuesEvent());
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
            MyArchivedIssuesList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetMyArchivedIssuesEvent());
        },
      ),
    );
  }
}
