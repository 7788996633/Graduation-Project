import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_event.dart';
import '../../../blocs/complaints_bloc/complaint_state.dart';
import '../../../data/models/complaint_model.dart';

class ComplaintTable extends StatefulWidget {
  final Color cardColor;
  final String tableTitle; // عنوان الجدول

  const ComplaintTable({
    super.key,
    required this.cardColor,
    this.tableTitle = 'Complaints', // قيمة افتراضية
  });

  @override
  State<ComplaintTable> createState() => _ComplaintTableState();
}

class _ComplaintTableState extends State<ComplaintTable> {
  late ComplaintBloc bloc;
  List<ComplaintModel> complaints = [];

  @override
  void initState() {
    super.initState();
    bloc = ComplaintBloc();

    // جلب البيانات عند الإنشاء
    bloc.add(GetAllComplaintsEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ComplaintBloc, ComplaintState>(
        builder: (context, state) {
          if (state is ComplaintListLoaded) {
            complaints = state.list;
            return buildTableContainer();
          } else if (state is ComplaintFail) {
            return Center(child: Text('Error: ${state.errMsg}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildTableContainer() {
    final isLight = widget.cardColor.computeLuminance() > 0.5;
    final textColor = isLight ? Colors.black : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان الجدول
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Center(
              child: Text(
                widget.tableTitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 12,
              headingRowHeight: 36,
              headingTextStyle: TextStyle(
                  color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
              dataTextStyle: TextStyle(color: textColor, fontSize: 13),
              columns: const [
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: complaints.map((complaint) {
                return DataRow(
                  cells: [
                    DataCell(Text(complaint.userName)),
                    DataCell(Text(
                      complaint.description.length > 30
                          ? '${complaint.description.substring(0, 30)}...'
                          : complaint.description,
                    )),
                    DataCell(
                      Text(
                        formatDate(complaint.date), // 🔥 صار مثل Consultation
                      ),
                    ),
                    DataCell(_buildStatusChip(complaint.status)),
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
    switch (status.toLowerCase()) {
      case 'completed':
        color = Colors.green;
        break;
      case 'pending':
        color = Colors.orange;
        break;
      case 'in progress':
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
