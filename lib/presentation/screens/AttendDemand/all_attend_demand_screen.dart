import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/screens/AttendDemand/add_attend_demand_screen.dart';

import '../../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import '../../widgets/attend_demand_list.dart';

class AllAttendDemandScreen extends StatelessWidget {
  const AllAttendDemandScreen({super.key, required this.issueId});
  final int issueId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => AttendDemandBloc(),
                    child: AttendDemandScreen(
                      issueId: issueId,
                    ),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
              create: (context) => AttendDemandBloc(),
              child: AttendDemandList(
                issueId: issueId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
