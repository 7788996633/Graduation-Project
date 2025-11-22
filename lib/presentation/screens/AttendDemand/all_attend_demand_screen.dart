import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import '../../../themes.dart';
import '../../widgets/attend_demand_list.dart';
import 'add_attend_demand_screen.dart';

class AllAttendDemandScreen extends StatelessWidget {
  const AllAttendDemandScreen({super.key, required this.issueId});
  final int issueId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],

      /*  appBar: AppBar(
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
      ), */
      body: Column(
        children: [
          BlocProvider(
            create: (context) => AttendDemandBloc(),
            child: AttendDemandList(
              issueId: issueId,
            ),
          ),
        ],
      ),
    );
  }
}
