import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../themes.dart';
import '../../widgets/consultation_request_list.dart';
import '../../widgets/custom_appbar_add.dart';

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
      appBar: CustomActionAppBar(
        title: 'Consultation Request ',),

      body: BlocProvider(
        create: (context) => ConsultationRequestBloc(),
        child: ConsultationRequestList(),
      ),
    );
  }
}
