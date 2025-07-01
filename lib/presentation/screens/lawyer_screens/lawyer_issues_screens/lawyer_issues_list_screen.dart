import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../data/models/issues_model.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/issue_item.dart';

class LawyerIssuesListScreen extends StatefulWidget {
  const LawyerIssuesListScreen({super.key});
  @override
  State<LawyerIssuesListScreen> createState() => _LawyerIssuesListScreenState();
}

class _LawyerIssuesListScreenState extends State<LawyerIssuesListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<IssuesBloc>(context).add(
      GetAllLawyerIssuesEvent(),
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
        title: 'Lawyer Issues ',
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
