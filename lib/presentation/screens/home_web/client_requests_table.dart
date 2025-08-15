import 'package:flutter/material.dart';

class ClientRequestsTable extends StatelessWidget {
  final Color cardColor;

  const ClientRequestsTable({super.key, required this.cardColor});

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

    // نصوص بلون عكس لون الخلفية لقراءة أفضل
    final textColor = cardColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client Requests',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 12,
              headingRowHeight: 36,
              headingTextStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
              dataTextStyle: TextStyle(color: textColor, fontSize: 13),
              columns: const [
                DataColumn(label: Text('Client')),
                DataColumn(label: Text('Request Type')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: requests.map((request) {
                return DataRow(
                  cells: [
                    DataCell(Text(request['client']!)),
                    DataCell(Text(request['type']!)),
                    DataCell(Text(request['date']!)),
                    DataCell(_buildStatusChip(request['status']!)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
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
      label: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      visualDensity: VisualDensity.compact,
    );
  }
}
