import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../blocs/sessions_bloc/sessions_event.dart';
import '../../blocs/sessions_bloc/sessions_state.dart';
import '../../data/models/session_model.dart';
import 'session_item.dart';

class SessionsList extends StatefulWidget {
  const SessionsList({super.key, required this.bloc});
  final SessionsBloc bloc;
  @override
  State<SessionsList> createState() => _SessionsListState();
}

class _SessionsListState extends State<SessionsList> {
  @override
  void initState() {
    widget.bloc.add(
      GetAllSessionsEvent(),
    );
    super.initState();
  }

  List<SessionModel> sessionsList = [];
  Widget buildSessionModel() {
    return ListView.builder(
      itemCount: sessionsList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => SessionItem(
        sessionModel: sessionsList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionsBloc, SessionsState>(
      listener: (context, state) {
        if (state is SessionsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          BlocProvider.of<SessionsBloc>(context).add(
            GetAllSessionsEvent(),
          );
        } else if (state is SessionsFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<SessionsBloc, SessionsState>(
        builder: (context, state) {
          if (state is SessionsListLoaded) {
            sessionsList = state.sessionsList;
            return sessionsList.isEmpty
                ? const Text('There is no sessions')
                : buildSessionModel();
          } else if (state is SessionsFail) {
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
    );
  }
}
