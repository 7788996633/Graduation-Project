import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../data/models/issues_model.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/issue_item.dart';

class UserIssuesScreens extends StatefulWidget {
  const UserIssuesScreens({super.key});
  @override
  State<UserIssuesScreens> createState() => _UserIssuesScreensState();
}

class _UserIssuesScreensState extends State<UserIssuesScreens> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<IssuesBloc>(context).add(
      GetAllClientIssuesEvent(),
    );
  }

  List<IssuesModel> allIssuesList = [];
  Widget buildIssuesList() {
    return ListView.builder(
      itemCount: allIssuesList.length,
      itemBuilder: (context, index) => IssueItem(
        issuesModel: allIssuesList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomActionAppBar(
        title: 'User Issues ',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<IssuesBloc, IssuesState>(
          builder: (context, state) {
            if (state is IssuesListLoadedSuccessFully) {
              allIssuesList = state.issues;
              return allIssuesList.isEmpty
                  ? const Center(
                      child: Text(
                        'There is no issues',
                      ),
                    )
                  : buildIssuesList();
            } else if (state is IssuesFail) {
              debugPrint(" Error: ${state.errmsg}");
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "There is an error:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.errmsg,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
