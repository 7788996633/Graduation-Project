import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/consultations_bloc/consultation_bloc.dart';

import '../../data/models/consultation_model.dart';
import 'consultations_lawyer_item.dart';

class MyConsultationsLawyerList extends StatefulWidget {
  const MyConsultationsLawyerList({super.key, required this.bloc});
  final ConsultationBloc bloc;

  @override
  State<MyConsultationsLawyerList> createState() => _MyConsultationsLawyerListState();
}

class _MyConsultationsLawyerListState extends State<MyConsultationsLawyerList> {
  List<ConsultationModel> consultations = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetMyConsultationsLawyer());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsultationBloc, ConsultationState>(
      listener: (context, state) {
        if (state is ConsultationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetMyConsultationsLawyer());
        } else if (state is ConsultationFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<ConsultationBloc, ConsultationState>(
        builder: (context, state) {
          if (state is ConsultationsListLoadedSuccessfully) {
            consultations = state.consultations;
            if (consultations.isEmpty) {
              return const Center(child: Text('There are no consultations'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: consultations.length,
                itemBuilder: (context, index) {
                  return MyConsultationsLawyerItem(
                    consultationModel: consultations[index],
                  );
                },
              ),
            );
          } else if (state is ConsultationFail) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  state.errmsg,
                  style: const TextStyle(fontSize: 16),
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
