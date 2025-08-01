import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/session_appointement_model.dart';

class AppointmentSessionDetailsScreen extends StatelessWidget {
  const AppointmentSessionDetailsScreen(
      {super.key, required this.sessionAppointementModel});
  final SessionAppointementModel sessionAppointementModel;
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yyyy-MM-dd').format(
      sessionAppointementModel.date,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          date,
        ),
      ),
      body: Column(
        children: [
          Text(
            date,
          ),
        ],
      ),
    );
  }
}
