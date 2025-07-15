import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import 'package:graduation/data/models/demand_model.dart';
import 'package:graduation/presentation/widgets/canvas/demands_chart.dart';

class MyDemandsScreen extends StatefulWidget {
  const MyDemandsScreen({super.key});

  @override
  State<MyDemandsScreen> createState() => _MyDemandsScreenState();
}

class _MyDemandsScreenState extends State<MyDemandsScreen> {
  @override
  void initState() {
    BlocProvider.of<AttendDemandBloc>(context).add(
      GetMyDemands(),
    );
    super.initState();
  }

  List<DemandModel> demands = [
    // DemandModel(
    //     id: 1,
    //     date: DateTime.now(),
    //     resault: '',
    //     issueId: 0,
    //     lawyerId: 0,
    //     createdAt: null,
    //     updatedAt: null),
    // DemandModel(
    //     id: 2,
    //     date: DateTime.now(),
    //     resault: '',
    //     issueId: 0,
    //     lawyerId: 0,
    //     createdAt: null,
    //     updatedAt: null),
    // DemandModel(
    //     id: 11,
    //     date: DateTime.now(),
    //     resault: '',
    //     issueId: 0,
    //     lawyerId: 0,
    //     createdAt: null,
    //     updatedAt: null),
    // DemandModel(
    //     id: 111,
    //     date: DateTime.now(),
    //     resault: '',
    //     issueId: 0,
    //     lawyerId: 0,
    //     createdAt: null,
    //     updatedAt: null),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Demands'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            BlocBuilder<AttendDemandBloc, AttendDemandState>(
              builder: (context, state) {
                if (state is DemandListLoadedSuccessfully) {
                  demands = state.listdemand;
                  return GoalChartWidget(data: demands);
                } else if (state is DemandFail) {
                  return Text(state.errmsg);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
