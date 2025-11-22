import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/responsive.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../data/models/lawyer_model.dart';
import '../../themes.dart';
import 'add_lawyers_to_issue_sheet.dart';
import 'custom_lawyer_item.dart';

class LawyersInIssueList extends StatefulWidget {
  const LawyersInIssueList({
    super.key,
    required this.issueId,
  });

  final int issueId;

  @override
  State<LawyersInIssueList> createState() => _LawyersInIssueListState();
}

class _LawyersInIssueListState extends State<LawyersInIssueList> {
  List<LawyerModel> _allLawyers = [];
  List<int> selectedLawyerIds = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LawyerInIssuesBloc>(context).add(
      GetAllLawyersInIssuesEvent(issueId: widget.issueId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LawyerInIssuesBloc, LawyerInIssuesState>(
      builder: (context, state) {
        if (state is LawyerInIssuesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LawyerInIssuesListLoadedSuccessfully) {
          _allLawyers = state.lawyerInissues;
          selectedLawyerIds = _allLawyers.map((lawyer) => lawyer.id).toList();
          return SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: s10),
              itemCount: _allLawyers.length + 1, // +1 لعنصر "Add Lawyers"
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                if (index < _allLawyers.length) {
                  // عنصر المحامي
                  return Container(
                    width: s120,
                    padding: EdgeInsets.all(s8),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 2,
                        colors: isLight.value
                            ? [
                                AppColors.darkBlue,
                                AppColors.softGray,
                                AppColors.white
                              ]
                            : [
                                Colors.black,
                                AppColors.softGray,
                                AppColors.white
                              ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: s30,
                          backgroundImage:
                              NetworkImage(_allLawyers[index].image),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _allLawyers[index].name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                } else {
                  if (myRole == 'admin') {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => LawyerBloc(),
                              ),
                              BlocProvider(
                                create: (context) => IssuesBloc(),
                              ),
                            ],
                            child:
                                AddLawyersToIssueSheet(issueId: widget.issueId),
                          ),
                        );
                      },
                      child: Container(
                        width: s120,
                        padding: EdgeInsets.all(s8),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 2,
                            colors: isLight.value
                                ? [
                                    AppColors.darkBlue,
                                    AppColors.softGray,
                                    AppColors.white
                                  ]
                                : [
                                    Colors.black,
                                    AppColors.softGray,
                                    AppColors.white
                                  ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            SizedBox(height: 10),
                            Text(
                              'Add Lawyers',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          );
        } else if (state is LawyerInIssuesFail) {
          return Center(
            child: Text(
              'Error: ${state.errmsg}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('No data yet.'));
        }
      },
    );
  }
}
