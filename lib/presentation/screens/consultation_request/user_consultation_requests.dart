import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/consultation_request_bloc/consultation_request_bloc.dart';
import '../../../themes.dart';
import '../../widgets/consultation_request_list.dart';

class UserConsultationRequests extends StatefulWidget {
  const UserConsultationRequests({super.key});

  @override
  State<UserConsultationRequests> createState() => _UserConsultationRequestsState();
}

class _UserConsultationRequestsState extends State<UserConsultationRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Consultation Requests',
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