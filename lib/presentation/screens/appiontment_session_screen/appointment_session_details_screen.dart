import 'package:flutter/material.dart';

import '../../../data/models/session_appointement_model.dart';

class AppointmentSessionDetailsScreen extends StatelessWidget {
  const AppointmentSessionDetailsScreen(
      {super.key, required this.sessionAppointementModel});
  final SessionAppointementModel sessionAppointementModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "${sessionAppointementModel.id}",
          ),
        ],
      ),
    );
  }
}
