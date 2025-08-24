import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constant.dart';

import '../../../blocs/session_points_bloc/session_points_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_event.dart';
import '../../../themes.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/sessions_list.dart';

import 'session_points_chart.dart';

class ListSessionsScreen extends StatefulWidget {
  const ListSessionsScreen({super.key, required this.issueId});
  final int issueId;

  @override
  State<ListSessionsScreen> createState() => _ListSessionsScreenState();
}

class _ListSessionsScreenState extends State<ListSessionsScreen> {
  late SessionsBloc bloc;
  bool isShowingAnalytics = false;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SessionsBloc>(context);
    bloc.add(
      GetSessionsByIsssueIdEvent(
        issueId: widget.issueId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      // appBar: CustomActionAppBar(
      //   title: 'Sessions',
      //   actionIcon: Icons.add_circle_rounded,
      //   tooltip: 'Add New Sessions',
      //   onActionPressed: () {
      //   },
      //   secondaryIcon: Icons.folder_copy_rounded,
      //   secondaryTooltip: 'View Session Documents',
      //   onSecondaryPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => BlocProvider(
      //           create: (_) => DocumentBloc(),
      //           child: ListDocumentsScreen(),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SessionsList(
                bloc: bloc,
                issueId: widget.issueId,
              ),
              if (myRole == 'admin') ...[
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    isShowingAnalytics = !isShowingAnalytics;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          size: 26,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${isShowingAnalytics ? "Hide" : "Show"} Analytics",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isShowingAnalytics)
                  SizedBox(
                    height: 350,
                    child: BlocProvider(
                      create: (context) => SessionPointsBloc(),
                      child: SessionPointsChart(
                        issueId: widget.issueId,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(
            GetSessionsByIsssueIdEvent(
              issueId: widget.issueId,
            ),
          );
        },
      ),
    );
  }
}
