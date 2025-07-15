import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../../blocs/session_appointment_bloc/session_appointment_bloc.dart';
import '../../../data/models/session_appointement_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_text_field.dart';

class UpdateAppointmentDateScreen extends StatefulWidget {
  const UpdateAppointmentDateScreen(
      {super.key, required this.sessionAppointementModel});
  final SessionAppointementModel sessionAppointementModel;
  @override
  State<UpdateAppointmentDateScreen> createState() =>
      _UpdateAppointmentDateScreenState();
}

class _UpdateAppointmentDateScreenState
    extends State<UpdateAppointmentDateScreen> {
  TextEditingController typeController = TextEditingController();

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
          "Update Appointment",
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
          Text(
            "Enter the appointment type",
          ),
          CustomTextFeild(
            text: "Type",
            controller: typeController,
            color: AppColors.darkBlue,
          ),
          BlocConsumer<SessionAppointmentBloc, SessionAppointmentState>(
            listener: (context, state) {
              if (state is SessionAppointmentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.successmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is SessionAppointmentFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is SessionAppointmentLoading) {
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
                  BlocProvider.of<SessionAppointmentBloc>(context).add(
                    UpdateAppointmentEvent(
                      idAddAppiontment: widget.sessionAppointementModel.id,
                      date: selectedDate.toString(),
                      type: typeController.text,
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
