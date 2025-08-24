import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/presentation/screens/session/create_session.dart';
import 'package:graduation/responsive.dart';

import '../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../blocs/sessions_bloc/sessions_event.dart';
import '../../blocs/sessions_bloc/sessions_state.dart';
import '../../data/models/session_model.dart';
import 'session_item.dart';

class SessionsList extends StatefulWidget {
  const SessionsList({super.key, required this.bloc, required this.issueId});
  final SessionsBloc bloc;
  final int? issueId;
  @override
  State<SessionsList> createState() => _SessionsListState();
}

class _SessionsListState extends State<SessionsList> {
  List<SessionModel> sessionsList = [];
  Widget buildSessionModel() {
    return ListView.builder(
      padding: EdgeInsets.all(0),
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
            widget.issueId == null
                ? GetAllSessionsEvent()
                : GetSessionsByIsssueIdEvent(
                    issueId: widget.issueId!,
                  ),
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
            return Column(
              children: [
                sessionsList.isEmpty
                    ? const Text('There is no sessions')
                    : buildSessionModel(),
                if (myRole == 'admin')
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => SessionsBloc(),
                            child:
                                CreateSessionScreen(issueId: widget.issueId!),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Add session",
                      style: TextStyle(
                          fontSize: s18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            );
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
