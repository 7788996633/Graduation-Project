import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/widgets/consultation_request_list.dart';
import 'package:graduation/themes.dart';

import '../../../blocs/consultation_request_bloc/consultation_request_bloc.dart';

class AllConsultationRequestsPage extends StatefulWidget {
  const AllConsultationRequestsPage({super.key});

  @override
  State<AllConsultationRequestsPage> createState() =>
      _AllConsultationRequestsPageState();
}

class _AllConsultationRequestsPageState
    extends State<AllConsultationRequestsPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Consultation Requests',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
      body: BlocProvider(
        create: (context) => ConsultationRequestBloc(),
        child: ConsultationRequestList(),
      ),
    );
  }
}
