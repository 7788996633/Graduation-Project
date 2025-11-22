import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_appointment_bloc/session_appointment_bloc.dart';
import '../../widgets/session_appointment_list.dart';

class AppointmentSessionListScreen extends StatelessWidget {
  const AppointmentSessionListScreen({super.key, required this.sessionId});
  final int sessionId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocProvider(
            create: (context) => SessionAppointmentBloc(),
            child: SessionAppointmentList(
              sessionId: sessionId,
            ),
          ),
        ],
      ),
    );
  }
}
