import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../blocs/session_type_bloc/session_type_event.dart';
import '../../data/models/session_type_model.dart';
import '../screens/session_type/session_type_details_screen.dart';

class SessionTypeItem extends StatelessWidget {
  const SessionTypeItem({super.key, required this.sessionTypeModel});
  final SessionTypeModel sessionTypeModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionTypeDetailsScreen(
                sessionTypeModel: sessionTypeModel,
              ),
            ),
          );
        },
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<SessionTypeBloc>(context).add(
              DeleteSessionTypeEvent(sessionTypeId: sessionTypeModel.id),
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        title: Text("Session Type ID :${sessionTypeModel.id}"),
        subtitle: Text("Type:  ${sessionTypeModel.type}"),
      ),
    );
  }
}
