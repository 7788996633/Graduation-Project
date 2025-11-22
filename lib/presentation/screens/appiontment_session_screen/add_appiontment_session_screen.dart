import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/themes.dart';

import '../../../blocs/session_appointment_bloc/session_appointment_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';
import '../../../responsive.dart';
import '../../widgets/session_type_selector.dart';

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
  int? selectedSessionTypeId;
  String? selectedSessionTypeName;

  void _showSessionTypeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => SessionTypeBloc()..add(GetAllSessionTypesEvent()),
        child: SessionTypeSelector(
          onSelected: (id, name) {
            setState(() {
              selectedSessionTypeId = id;
              selectedSessionTypeName = name;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

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
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: getCurrentTheme()['AppBar'],
        title: Text(
          'Add session appintment',
          style: TextStyle(
            color: Colors.white,
            fontSize: s24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropdown for Type
                Text(
                  "Session Type:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _showSessionTypeSelector,
                  child: Text(
                    selectedSessionTypeName ?? "Select Session Type",
                  ),
                ),
                const SizedBox(height: 20),

                // Date Picker
                Row(
                  children: [
                    Text('Date: ${selectedDate.toLocal()}'.split(' ')[0]),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select date'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (selectedSessionTypeName != null) {
                      context.read<SessionAppointmentBloc>().add(
                            AddAppiontmentEvent(
                              type: selectedSessionTypeName!,
                              date: selectedDate.toString(),
                              sessionId: widget.sessionId,
                            ),
                          );
                    }
                  },
                  child: const Text('Save'),
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
