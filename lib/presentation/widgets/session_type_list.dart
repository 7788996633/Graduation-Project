import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../blocs/session_type_bloc/session_type_event.dart';

import '../../data/models/session_type_model.dart';
import 'session_type_item.dart';

class SessionTypeList extends StatefulWidget {
  const SessionTypeList({super.key, required this.bloc});
  final SessionTypeBloc bloc;

  @override
  State<SessionTypeList> createState() => _SessionTypeListState();
}

class _SessionTypeListState extends State<SessionTypeList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllSessionTypesEvent());
  }

  List<SessionTypeModel> sessionTypeList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionTypeBloc, SessionTypeState>(
      listener: (context, state) {
        if (state is SessionTypeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllSessionTypesEvent());
        } else if (state is SessionTypeFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<SessionTypeBloc, SessionTypeState>(
        builder: (context, state) {
          if (state is SessionTypeListLoaded) {
            sessionTypeList = state.list;
            if (sessionTypeList.isEmpty) {
              return const Center(child: Text('There are no session types'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: sessionTypeList.length,
                itemBuilder: (context, index) {
                  return SessionTypeItem(sessionTypeModel: sessionTypeList[index]);
                },
              ),
            );
          } else if (state is SessionTypeFail) {
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
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
