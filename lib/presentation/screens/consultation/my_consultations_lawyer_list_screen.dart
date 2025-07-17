import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/consultations_bloc/consultation_bloc.dart';

import '../../../themes.dart';
import '../../widgets/consultation_list.dart';
import '../../widgets/consultations_lawyer_list.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';

class MyConsultationsLawyerListScreen extends StatefulWidget {
  const MyConsultationsLawyerListScreen({super.key});

  @override
  State<MyConsultationsLawyerListScreen> createState() =>
      _MyConsultationsLawyerListScreenState();
}

class _MyConsultationsLawyerListScreenState
    extends State<MyConsultationsLawyerListScreen> {
  late ConsultationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ConsultationBloc>(context);
    bloc.add(GetMyConsultationsLawyer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const CustomActionAppBar(
        title: 'My Consultations',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MyConsultationsLawyerList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetMyConsultationsLawyer());
        },
      ),
    );
  }
}
