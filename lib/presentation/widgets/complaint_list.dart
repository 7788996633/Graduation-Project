import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../blocs/complaints_bloc/complaint_event.dart';
import '../../blocs/complaints_bloc/complaint_state.dart';
import '../../data/models/complaint_model.dart';
import 'complaint_item.dart';

class ComplaintList extends StatefulWidget {
  const ComplaintList({super.key, required this.bloc});
  final ComplaintBloc bloc;

  @override
  State<ComplaintList> createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetAllComplaintsEvent());
  }

  List<ComplaintModel> complaintList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplaintBloc, ComplaintState>(
      listener: (context, state) {
        if (state is ComplaintSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllComplaintsEvent());
        } else if (state is ComplaintFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<ComplaintBloc, ComplaintState>(
        builder: (context, state) {
          if (state is ComplaintListLoaded) {
            complaintList = state.list;
            if (complaintList.isEmpty) {
              return const Center(child: Text('There are no complaints'));
            }
            return ListView.builder(
                itemCount: complaintList.length,
                itemBuilder: (context, index) {
                  return ComplaintItem(complaintModel: complaintList[index]);
                },

            );
          } else if (state is ComplaintFail) {
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
                  state.errMsg,
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
