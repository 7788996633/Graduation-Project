import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import '../../../data/models/demand_model.dart';

class UpdateAttendDemandScreen extends StatefulWidget {
  const UpdateAttendDemandScreen({super.key, required this.demandModel});
  final DemandModel demandModel;
  @override
  State<UpdateAttendDemandScreen> createState() =>
      _UpdateAttendDemandScreenState();
}

class _UpdateAttendDemandScreenState extends State<UpdateAttendDemandScreen> {
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yyyy-MM-dd').format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Date",
        ),
      ),
      body: Column(
        children: [
          Text(
            "The current date is $date",
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(
              "Select the new date",
            ),
          ),
          BlocConsumer<AttendDemandBloc, AttendDemandState>(
            listener: (context, state) {
              if (state is DemandSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.successmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is DemandFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is DemandLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Loading ...",
                      style: TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.grey,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AttendDemandBloc>(context).add(
                    UpdateDemandDateEvent(
                      idDemand: widget.demandModel.id,
                      date: selectedDate.toString(),
                    ),
                  );
                },
                child: Text(
                  "Save",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
