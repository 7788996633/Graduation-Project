import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../blocs/interview_bloc/interview_bloc.dart';
import '../../../../blocs/interview_bloc/interview_event.dart';
import '../../../../constant.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/interview_list.dart';
import '../../../widgets/refresh_button.dart';
import 'add_interview_screen.dart';
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
    bloc.add(GetAllInterviewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Interviews',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Interview',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => InterviewBloc(),
                child: const AddInterviewScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            InterviewList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllInterviewsEvent());
        },
      ),
    );
  }
}
