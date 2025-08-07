import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/session_appointment_bloc/session_appointment_bloc.dart';
import '../../data/models/session_appointement_model.dart';
import 'session_appointment_item.dart';

class SessionAppointmentList extends StatefulWidget {
  const SessionAppointmentList({super.key, required this.sessionId});
  final int sessionId;
  @override
  State<SessionAppointmentList> createState() => _SessionAppointmentListState();
}

class _SessionAppointmentListState extends State<SessionAppointmentList> {
  @override
  void initState() {
    BlocProvider.of<SessionAppointmentBloc>(context).add(
      GetAllAppointmentBySessionEvent(sessionId: widget.sessionId),
    );
    super.initState();
  }

  List<SessionAppointementModel> sessionAppointmentList = [];
  Widget buildSessionAppointmentListList() {
    return ListView.builder(
      itemCount: sessionAppointmentList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => SessionAppointmentItem(
        sessionAppointementModel: sessionAppointmentList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SessionAppointmentBloc, SessionAppointmentState>(
          builder: (context, state) {
            if (state is SessionAppointmentListLoadedSuccessfully) {
              sessionAppointmentList = state.listAppointemnt;
              return sessionAppointmentList.isEmpty
                  ? const Text('There is no SessionAppointmentLists')
                  : buildSessionAppointmentListList();
            } else if (state is SessionAppointmentFail) {
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
