import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_appointment_bloc/session_appointment_bloc.dart';

class AppointmentScreen extends StatefulWidget {
  final int sessionId;

  const AppointmentScreen({super.key, required this.sessionId});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String? selectedType;
  DateTime selectedDate = DateTime.now();
  final List<String> typeOptions = ['Type 1', 'Type 2', 'Type 3', 'Type 4'];

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز موعد'),
      ),
      body: BlocConsumer<SessionAppointmentBloc, SessionAppointmentState>(
        listener: (context, state) {
          if (state is SessionAppointmentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successmsg)),
            );
          } else if (state is SessionAppointmentFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errmsg)),
            );
          }
        },
        builder: (context, state) {
          if (state is SessionAppointmentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Dropdown for Type
                DropdownButtonFormField<String>(
                  value: selectedType,
                  hint: const Text('اختر نوع الحجز'),
                  items: typeOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedType = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'نوع الحجز',
                  ),
                  validator: (value) =>
                      value == null ? 'الرجاء اختيار النوع' : null,
                ),

                const SizedBox(height: 20),

                // Date Picker
                Row(
                  children: [
                    Text('التاريخ: ${selectedDate.toLocal()}'.split(' ')[0]),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('اختر التاريخ'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (selectedType != null) {
                      context.read<SessionAppointmentBloc>().add(
                            AddAppiontmentEvent(
                              type: selectedType!,
                              date: selectedDate.toString(),
                              sessionId: widget.sessionId,
                            ),
                          );
                    }
                  },
                  child: const Text('حفظ الموعد'),
                ),

                if (state is SessionAppointmentListLoadedSuccessfully)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.listAppointemnt.length,
                      itemBuilder: (context, index) {
                        final appointment = state.listAppointemnt[index];
                        return ListTile(
                          title: Text(appointment.type),
                          subtitle: Text(
                            appointment.date.toString(),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
