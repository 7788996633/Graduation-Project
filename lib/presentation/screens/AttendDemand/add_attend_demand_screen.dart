import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import '../../../responsive.dart';
import '../../../themes.dart';

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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: getCurrentTheme()['AppBar'],
        title: Text(
          'Add Demand',
          style: TextStyle(
            color: Colors.white,
            fontSize: s24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          margin: EdgeInsets.all(s12),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 2,
              colors: isLight
                  ? [
                      AppColors.darkBlue,
                      AppColors.softGray,
                      AppColors.white,
                    ]
                  : [
                      Colors.black,
                      AppColors.softGray,
                      AppColors.white,
                    ],
            ),
            border: Border.all(
              strokeAlign: 2,
              width: 3,
              color: AppColors.white,
            ),
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => _selectDate(context),
                child: Text(
                  "Select a date for the next demand",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: s16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                selected
                    ? "You have selected: $date"
                    : 'You should select date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: s20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
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
                    Navigator.of(context).pop();
                    BlocProvider.of<AttendDemandBloc>(context)
                        .add(GetAllDemandByIssueEvent(issueId: widget.issueId));
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: s20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
