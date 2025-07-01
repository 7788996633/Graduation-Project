import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/screens/admin_screens/issues_screens.dart/create_issue_screen.dart';
import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../constant.dart';
import '../../../../data/models/issues_model.dart';
import '../../../widgets/issue_item.dart';

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
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => IssuesBloc(),
                    child: const CreateIssueScreen(),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
        backgroundColor: AppColors.darkBlue,
        title: const Text(
          "All Issues",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
              debugPrint("🛑 Error: ${state.errmsg}");
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
