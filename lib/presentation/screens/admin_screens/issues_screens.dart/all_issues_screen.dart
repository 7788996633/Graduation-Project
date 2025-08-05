import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../constant.dart';
import '../../../../data/filters/filters_strategy.dart';
import '../../../../data/models/issues_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/issues_filter_bottom_sheet.dart';
import '../../../widgets/user_issue_item.dart';
import 'create_issue_screen.dart';

class AllIssuesScreen extends StatefulWidget {
  const AllIssuesScreen({super.key});
  @override
  State<AllIssuesScreen> createState() => _AllIssuesScreenState();
}

class _AllIssuesScreenState extends State<AllIssuesScreen> {
  late IssuesBloc issuesBloc;
  @override
  void initState() {
    super.initState();
    issuesBloc = BlocProvider.of<IssuesBloc>(context);
    issuesBloc.add(GetAllIssuesEvent());
  }

  List<IssuesModel> allIssuesList = [];

  Widget buildIssuesList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _searchText.isEmpty ? allIssuesList.length : filterd.length,
      itemBuilder: (context, index) => UserIssueItem(
        issuesModel:
            _searchText.isEmpty ? allIssuesList[index] : filterd[index],
        issuesBloc: issuesBloc,
      ),
    );
  }

  String _searchText = '';

  List<IssuesModel> filterd = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomActionAppBar(
        secondaryIcon: myRole == 'admin' ? Icons.sort : null,
        onSecondaryPressed: () async {
          final filter =
              await showModalBottomSheet<FiltersStrategy<IssuesModel>>(
            barrierColor: Colors.grey.withOpacity(
              0.6,
            ),
            context: context,
            builder: (_) => const IssuesFilterBottomSheet(),
          );
          if (filter != null) {
            issuesBloc.add(FilterIssues(filter));
          }
        },
        title: 'Issues',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  color: getCurrentTheme()['BoldText'],
                ),
                onChanged: (value) {
                  _searchText = value;
                  if (value.isNotEmpty) {
                    filterd = allIssuesList
                        .where(
                          (element) =>
                              element.issueNumber
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element.user.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              element.title
                                  .toLowerCase()
                                  .contains(value.toLowerCase()),
                        )
                        .toList();
                  } else {
                    filterd = allIssuesList;
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.search,
                    color: getCurrentTheme()['Icons'],
                  ),
                  hintText: "Search by name, user or type...",
                  hintStyle: TextStyle(
                    color: getCurrentTheme()['BoldText'],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<IssuesBloc, IssuesState>(
                builder: (context, state) {
                  if (state is IssuesListLoadedSuccessFully) {
                    allIssuesList = state.issues;
                    return allIssuesList.isEmpty
                        ? const Center(child: Text('There is no issues'))
                        : buildIssuesList();
                  } else if (state is IssuesSuccess) {
                    BlocProvider.of<IssuesBloc>(context)
                        .add(GetAllIssuesEvent());
                    return const SizedBox();
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
            ],
          ),
        ),
      ),
    );
  }
}
