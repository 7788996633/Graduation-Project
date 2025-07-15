import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../data/models/session_appointement_model.dart';
import '../screens/appiontment_session_screen/appointment_session_details_screen.dart';

class SessionAppointmentItem extends StatelessWidget {
  const SessionAppointmentItem(
      {super.key, required this.sessionAppointementModel});
  final SessionAppointementModel sessionAppointementModel;

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yyyy-MM-dd').format(
      sessionAppointementModel.date,
    );

    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AppointmentSessionDetailsScreen(
                sessionAppointementModel: sessionAppointementModel,
              ),
            ),
          );
        },
        title: Text(
          date,
        ),
      ),
    );
  }
}
