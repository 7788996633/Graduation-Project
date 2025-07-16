import 'package:flutter/material.dart';

enum AttendStatus { attend, absent }

class AttendRadio extends StatefulWidget {
  final AttendStatus? selectedStatus;
  final ValueChanged<AttendStatus?> onChanged;

  const AttendRadio({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  State<AttendRadio> createState() => _AttendRadioState();
}

class _AttendRadioState extends State<AttendRadio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Attend Status",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListTile(
          title: const Text('Attend'),
          leading: Radio<AttendStatus>(
            value: AttendStatus.attend,
            groupValue: widget.selectedStatus,
            onChanged: widget.onChanged,
          ),
        ),
        ListTile(
          title: const Text('Absent'),
          leading: Radio<AttendStatus>(
            value: AttendStatus.absent,
            groupValue: widget.selectedStatus,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
