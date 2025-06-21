import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../blocs/sessions_bloc/sessions_event.dart';
import '../../data/models/session_model.dart';
import '../screens/session/session_details_screen.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({super.key, required this.sessionModel});
  final SessionModel sessionModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionDetailsScreen(
                sessionModel: sessionModel,
              ),
            ),
          );
        },
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<SessionsBloc>(context).add(
              DeleteSessionEvent(sessionId: sessionModel.sessionId),
            );
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        title: Text("${sessionModel.sessionId}"),
        subtitle: Text(sessionModel.type),
      ),
    );
  }
}
