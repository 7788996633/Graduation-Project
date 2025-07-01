import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/interview_bloc/interview_bloc.dart';
import '../../blocs/interview_bloc/interview_event.dart';

import '../../blocs/interview_bloc/interviews_state.dart';
import '../../data/models/interview_model.dart';
import 'interview_item.dart';

class InterviewList extends StatefulWidget {
  const InterviewList({super.key, required this.bloc});
  final InterviewBloc bloc;

  @override
  State<InterviewList> createState() => _InterviewListState();
}

class _InterviewListState extends State<InterviewList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllInterviewsEvent());
  }

  List<InterviewModel> interviewList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<InterviewBloc, InterviewState>(
      listener: (context, state) {
        if (state is InterviewSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllInterviewsEvent());
        } else if (state is InterviewFail) {
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
      child: BlocBuilder<InterviewBloc, InterviewState>(
        builder: (context, state) {
          if (state is InterviewListLoaded) {
            interviewList = state.list;
            if (interviewList.isEmpty) {
              return const Center(child: Text('There are no interviews'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: interviewList.length,
                itemBuilder: (context, index) {
                  return InterviewItem(interviewModel: interviewList[index]);
                },
              ),
            );
          } else if (state is InterviewFail) {
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
