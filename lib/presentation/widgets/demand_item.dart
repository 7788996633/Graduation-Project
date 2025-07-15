import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../data/models/demand_model.dart';
import '../screens/AttendDemand/demand_details_screen.dart';

class DemandItem extends StatelessWidget {
  const DemandItem({super.key, required this.demandModel});
  final DemandModel demandModel;

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yyyy-MM-dd').format(demandModel.date);

    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => LawyerProfileBloc(),
                child: DemandDetailsScreen(
                  demandModel: demandModel,
                ),
              ),
            ),
          );
        },
        title: Text(
          date,
        ),
        subtitle: Text(demandModel.resault ?? "There is no resault yet"),
      ),
    );
  }
}
