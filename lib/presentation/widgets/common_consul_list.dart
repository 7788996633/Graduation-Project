import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../blocs/common_consultation_bloc/common _consultation_event.dart';
import '../../blocs/common_consultation_bloc/common _consultation_state.dart';

import '../../data/models/common _consultation_model.dart';

import 'common_consul_item.dart';


class CommonConsultationList extends StatefulWidget {
  const CommonConsultationList({super.key, required this.bloc});
  final CommonConsultationBloc bloc;

  @override
  State<CommonConsultationList> createState() => _CommonConsultationListState();
}

class _CommonConsultationListState extends State<CommonConsultationList> {
  List<CommonConsultationModel> consultationList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllCommonConsultation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommonConsultationBloc, CommonConsultationState>(
      listener: (context, state) {
        if (state is CommonConsultationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllCommonConsultation());
        } else if (state is CommonConsultationFail) {
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
      child: BlocBuilder<CommonConsultationBloc, CommonConsultationState>(
        builder: (context, state) {
          if (state is CommonConsultationListLoaded) {
            consultationList = state.commonConsultationList;
            if (consultationList.isEmpty) {
              return const Center(child: Text('There are no consultations'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: consultationList.length,
                itemBuilder: (context, index) {
                  return CommonConsultationItem(
                    consultationModel: consultationList[index],
                  );
                },
              ),
            );
          } else if (state is CommonConsultationFail) {
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
                  state.errmsg,
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
