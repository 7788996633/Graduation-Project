import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constant.dart';

import '../../blocs/consultation_request_bloc/consultation_request_bloc.dart';
import '../../data/models/cons_req_model.dart';
import 'consultation_request_item.dart';

class ConsultationRequestList extends StatefulWidget {
  const ConsultationRequestList({super.key});

  @override
  State<ConsultationRequestList> createState() =>
      _ConsultationRequestListState();
}

class _ConsultationRequestListState extends State<ConsultationRequestList> {
  late ConsultationRequestBloc consultationRequestBloc;

  @override
  void initState() {
    consultationRequestBloc = BlocProvider.of<ConsultationRequestBloc>(context);
    consultationRequestBloc.add(
      myRole == 'user'
          ? GetUserConsultationRequestStatusEvent()
          : GetAllConsultationRequestStatusEvent(),
    );
    super.initState();
  }

  List<ConsReqModel> consultationsRequestsList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationRequestBloc, ConsultationRequestState>(
      builder: (context, state) {
        if (state is ConsultationRequestListLoadedSuccessFully) {
          consultationsRequestsList = state.consultationRequest;
          return buildList();
        } else if (state is ConsultationRequestSuccess) {
          consultationRequestBloc.add(
            myRole == 'user'
                ? GetUserConsultationRequestStatusEvent()
                : GetAllConsultationRequestStatusEvent(),
          );
          return 
          consultationsRequestsList.isNotEmpty
              ? buildList()
              : Center(
                  child: Text('No data'),
                );
        } else if (state is ConsultationRequestFail) {
          return Center(
            child: Text('حدث خطأ: ${state.errmsg}'),
          );
        } else {
          return Center(child: Text('جاري التحميل...'));
        }
      },
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: consultationsRequestsList.length,
      itemBuilder: (context, index) {
        final request = consultationsRequestsList[index];
        return ConsultationRequestItem(
          consReqModel: request,
          consultationRequestBloc: consultationRequestBloc,
        );
      },
    );
  }
}
