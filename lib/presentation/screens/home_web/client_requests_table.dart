import 'package:flutter/material.dart';

class ClientRequestsTable extends StatelessWidget {
  const ClientRequestsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> requests = [
      {
        'client': 'John Doe',
        'type': 'Consultation',
        'date': '2025-05-28',
        'status': 'Pending',
      },
      {
        'client': 'Amina Khaled',
        'type': 'Legal Advice',
        'date': '2025-05-27',
        'status': 'Completed',
      },
      {
        'client': 'Ali Hassan',
        'type': 'Court Representation',
        'date': '2025-05-26',
        'status': 'In Progress',
      },
    ];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Client Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Client')),
                  DataColumn(label: Text('Request Type')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Status')),
                ],
                rows: requests.map((request) {
                  return DataRow(cells: [
                    DataCell(Text(request['client']!)),
                    DataCell(Text(request['type']!)),
                    DataCell(Text(request['date']!)),
                    DataCell(_buildStatusChip(request['status']!)),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Completed':
        color = Colors.green;
        break;
      case 'Pending':
        color = Colors.orange;
        break;
      case 'In Progress':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
