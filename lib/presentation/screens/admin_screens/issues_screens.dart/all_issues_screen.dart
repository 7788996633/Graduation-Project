import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../data/models/issues_model.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/issue_item.dart';
import 'create_issue_screen.dart';

class AllIssuesScreen extends StatefulWidget {
  const AllIssuesScreen({super.key});
  @override
  State<AllIssuesScreen> createState() => _AllIssuesScreenState();
}

class _AllIssuesScreenState extends State<AllIssuesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<IssuesBloc>(context).add(
      GetAllIssuesEvent(),
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
        title: 'List Issue ',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Issue',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssuesBloc(),
                child: const CreateIssueScreen(),
              ),
            ),
          );
        },
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<IssuesBloc, IssuesState>(
          builder: (context, state) {
            if (state is IssuesListLoadedSuccessFully) {
              allIssuesList = state.issues;
              return allIssuesList.isEmpty
                  ? const Center(child: Text('There is no issues'))
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
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
