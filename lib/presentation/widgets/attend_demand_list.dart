import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/themes.dart';

import '../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import '../../constant.dart';
import '../../data/models/demand_model.dart';
import '../../responsive.dart';
import '../screens/AttendDemand/add_attend_demand_screen.dart';
import 'demand_item.dart';

class AttendDemandList extends StatefulWidget {
  const AttendDemandList({super.key, required this.issueId});
  final int issueId;
  @override
  State<AttendDemandList> createState() => _AttendDemandListState();
}

class _AttendDemandListState extends State<AttendDemandList> {
  @override
  void initState() {
    BlocProvider.of<AttendDemandBloc>(context).add(
      GetAllDemandByIssueEvent(issueId: widget.issueId),
    );
    super.initState();
  }

  List<DemandModel> attendDemandList = [];
  Widget buildDemandList() {
    return ListView.builder(
      itemCount: attendDemandList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => DemandItem(
        demandModel: attendDemandList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AttendDemandBloc, AttendDemandState>(
          builder: (context, state) {
            if (state is DemandListLoadedSuccessfully) {
              attendDemandList = state.listdemand;
              return Column(
                children: [
                  attendDemandList.isEmpty
                      ? Center(
                          child: const Text('There is no Demands'),
                        )
                      : buildDemandList(),
                  if (myRole == 'lawyer')
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AttendDemandBloc(),
                              child: AttendDemandScreen(
                                issueId: widget.issueId,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Add Demand",
                        style: TextStyle(
                            fontSize: s18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              );
            } else if (state is DemandFail) {
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
