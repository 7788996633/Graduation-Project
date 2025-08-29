import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/interview_bloc/interview_event.dart';

import '../../../../blocs/interview_bloc/interviews_state.dart';
import '../../../../themes.dart';
import '../../../../data/models/interview_model.dart';

import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/interview_item.dart';

class ListInterviewsScreen extends StatefulWidget {
  final int jobApplicationId;

  const ListInterviewsScreen({
    super.key,
    required this.jobApplicationId,
  });

  @override
  State<ListInterviewsScreen> createState() => _ListInterviewsScreenState();
}

class _ListInterviewsScreenState extends State<ListInterviewsScreen> {
  late InterviewBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<InterviewBloc>(context);
    bloc.add(GetAllInterviewsEvent(widget.jobApplicationId));
  }

  Future<void> _onRefresh() async {
    bloc.add(GetAllInterviewsEvent(widget.jobApplicationId));
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const CustomActionAppBar(
        title: 'List Interviews',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<InterviewBloc, InterviewState>(
            builder: (context, state) {
              if (state is InterviewLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is InterviewFail) {
                return Center(child: Text(state.errMsg));
              } else if (state is InterviewListLoaded) {
                final List<InterviewModel> interviews = state.list;
                if (interviews.isEmpty) {
                  return const Center(child: Text('No Interviews Available'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: interviews.length,
                  itemBuilder: (context, index) {
                    return InterviewItem(interviewModel: interviews[index],);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
