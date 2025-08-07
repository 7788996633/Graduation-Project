import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/archive_bloc/archive_bloc.dart';
import '../../blocs/archive_bloc/archive_event.dart';

import '../../data/models/archive_model.dart';
import 'archived_issues_item.dart';

class ArchivedIssuesList extends StatefulWidget {
  const ArchivedIssuesList({super.key, required this.bloc});
  final ArchiveBloc bloc;

  @override
  State<ArchivedIssuesList> createState() => _ArchivedIssuesListState();
}

class _ArchivedIssuesListState extends State<ArchivedIssuesList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllArchivedIssuesEvent());
  }

  List<ArchiveModel> archivedIssuesList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArchiveBloc, ArchiveState>(
      listener: (context, state) {
        if (state is ArchiveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllArchivedIssuesEvent());
        } else if (state is ArchiveFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<ArchiveBloc, ArchiveState>(
        builder: (context, state) {
          if (state is ArchiveListLoaded) {
            archivedIssuesList = state.list;
            if (archivedIssuesList.isEmpty) {
              return const Center(child: Text('There are no archived issues'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: archivedIssuesList.length,
                itemBuilder: (context, index) {
                  return ArchivedIssuesItem(archiveModel: archivedIssuesList[index]);
                },
              ),
            );
          } else if (state is ArchiveFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
