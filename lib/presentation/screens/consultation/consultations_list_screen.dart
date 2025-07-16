import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/consultations_bloc/consultation_bloc.dart';
import 'package:graduation/presentation/widgets/consultation_list.dart';

class ConsultationsListScreen extends StatefulWidget {
  const ConsultationsListScreen({super.key});

  @override
  State<ConsultationsListScreen> createState() =>
      _ConsultationsListScreenState();
}

class _ConsultationsListScreenState extends State<ConsultationsListScreen> {
  @override
  void initState() {
    BlocProvider.of<ConsultationBloc>(context).add(
      GetAllConsultationsEvent(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Consultations Screen",
        ),
      ),
      body: BlocBuilder<ConsultationBloc, ConsultationState>(
        builder: (context, state) {
          if (state is ConsultationsListLoadedSuccessfully) {
            return ConsultationList(
              consultations: state.consultations,
            );
          } else if (state is ConsultationFail) {
            return Text(state.errmsg);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
