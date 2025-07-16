import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../data/models/issues_model.dart';
import 'issue_item.dart';

class AllIssuesList extends StatefulWidget {
  const AllIssuesList({super.key});

  @override
  State<AllIssuesList> createState() => _AllIssuesListState();
}

class _AllIssuesListState extends State<AllIssuesList> {
  @override
  void initState() {
    BlocProvider.of<IssuesBloc>(context).add(
      GetAllIssuesEvent(),
    );
    super.initState();
  }

  List<IssuesModel> allIssuesList = [];
  Widget buildIssuesList() {
    return ListView.builder(
      itemCount: allIssuesList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => IssueItem(
        issuesModel: allIssuesList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<IssuesBloc, IssuesState>(
          builder: (context, state) {
            if (state is IssuesListLoadedSuccessFully) {
              allIssuesList = state.issues;
              return allIssuesList.isEmpty
                  ? const Text('There is no issues')
                  : buildIssuesList();
            } else if (state is IssuesFail) {
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
                    state.errmsg,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
