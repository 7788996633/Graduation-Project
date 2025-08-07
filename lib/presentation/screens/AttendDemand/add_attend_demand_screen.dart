import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';

class AttendDemandScreen extends StatefulWidget {
  const AttendDemandScreen({super.key, required this.issueId});
  final int issueId;
  @override
  State<AttendDemandScreen> createState() => _AttendDemandScreenState();
}

class _AttendDemandScreenState extends State<AttendDemandScreen> {
  bool selected = false;
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
        selected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Demand'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(
              "Select Date",
            ),
          ),
          Text(
              selected ? "You have selected: $date" : 'You should select date'),
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
                    AddDemandEvent(
                      idIssue: widget.issueId,
                      date: selectedDate.toString(),
                    ),
                  );
                },
                child: Text(
                  "Add",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
