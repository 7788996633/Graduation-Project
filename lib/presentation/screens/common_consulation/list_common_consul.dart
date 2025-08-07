import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_event.dart';
import '../../../themes.dart';
import '../../widgets/common_consul_list.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/custom_search_bar.dart';

import 'add_common_consul.dart';

class ListCommonConsultationsScreen extends StatefulWidget {
  const ListCommonConsultationsScreen({super.key});

  @override
  State<ListCommonConsultationsScreen> createState() =>
      _ListCommonConsultationsScreenState();
}

class _ListCommonConsultationsScreenState
    extends State<ListCommonConsultationsScreen> {
  late CommonConsultationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CommonConsultationBloc>(context);
    bloc.add(GetAllCommonConsultation());
  }

  void _onSearch(String question) {
    if (question.trim().isNotEmpty) {
      bloc.add(SearchCommonConsultationsByQuestionEvent(question: question));
    } else {
      bloc.add(GetAllCommonConsultation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomActionAppBar(
        title: 'List Common Consultations',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Consultation',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => CommonConsultationBloc(),
                child: const AddCommonConsultationScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(
              hint: 'Search by Question',
              onSearch: _onSearch,
            ),
            const SizedBox(height: 20),
            CommonConsultationList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllCommonConsultation());
        },
      ),
    );
  }
}
