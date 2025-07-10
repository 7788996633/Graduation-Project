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
        padding: const EdgeInsets.all(12), // تقليل الحشو
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Client Requests',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // تصغير الخط
            ),
            const SizedBox(height: 12), // تقليل الفراغ
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 12, // تقليل المسافة بين الأعمدة
                dataRowHeight: 36, // تقليل ارتفاع الصف
                headingRowHeight: 36, // تقليل ارتفاع رأس الجدول
                columns: const [
                  DataColumn(
                    label: Text(
                      'Client',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Request Type',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
                rows: requests.map((request) {
                  return DataRow(
                    cells: [
                      DataCell(Text(request['client']!, style: const TextStyle(fontSize: 13))),
                      DataCell(Text(request['type']!, style: const TextStyle(fontSize: 13))),
                      DataCell(Text(request['date']!, style: const TextStyle(fontSize: 13))),
                      DataCell(_buildStatusChip(request['status']!)),
                    ],
                  );
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
      label: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 12), // تصغير الخط داخل الشيب
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0), // تقليل padding داخل الشيب
      visualDensity: VisualDensity.compact, // لجعل الشيب مضغوط
    );
  }
}
