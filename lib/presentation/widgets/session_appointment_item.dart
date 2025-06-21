import 'package:flutter/material.dart';

import '../../data/models/session_appointement_model.dart';

class SessionAppointmentItem extends StatelessWidget {
  const SessionAppointmentItem(
      {super.key, required this.sessionAppointementModel});
  final SessionAppointementModel sessionAppointementModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "${sessionAppointementModel.id}",
        ),
      ),
    );
  }
}
