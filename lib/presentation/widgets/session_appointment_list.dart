import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/presentation/screens/appiontment_session_screen/add_appiontment_session_screen.dart';
import 'package:graduation/responsive.dart';
import 'package:graduation/themes.dart';

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
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: s8,
      ),
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
    return Container(
      padding: EdgeInsets.all(s12),
      child: Column(
        children: [
          Text(
            "The appointments in this session",
            style: TextStyle(
                color: getCurrentTheme()['NormalText'],
                fontSize: s20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: s10,
          ),
          BlocBuilder<SessionAppointmentBloc, SessionAppointmentState>(
            builder: (context, state) {
              if (state is SessionAppointmentListLoadedSuccessfully) {
                sessionAppointmentList = state.listAppointemnt;
                return Column(
                  children: [
                    sessionAppointmentList.isEmpty
                        ? const Text('There is no SessionAppointmentLists')
                        : buildSessionAppointmentListList(),
                    if (myRole != 'user')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => SessionAppointmentBloc(),
                              child: AppointmentScreen(
                                  sessionId: widget.sessionId),
                            ),
                          ));
                        },
                        child: Text(
                          "Add appointments",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                );
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
      ),
    );
  }
}
