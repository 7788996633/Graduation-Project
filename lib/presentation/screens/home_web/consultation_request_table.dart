import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../data/models/cons_req_model.dart';
import '../../../constant.dart';

class ConsultationRequestTable extends StatefulWidget {
  final Color cardColor;
  final String tableTitle; // Table title
  const ConsultationRequestTable({
    super.key,
    required this.cardColor,
    this.tableTitle = 'Consultation Requests', // Default value
  });

  @override
  State<ConsultationRequestTable> createState() =>
      _ConsultationRequestTableState();
}

class _ConsultationRequestTableState extends State<ConsultationRequestTable> {
  late ConsultationRequestBloc bloc;
  List<ConsReqModel> requests = [];

  @override
  void initState() {
    super.initState();
    bloc = ConsultationRequestBloc();

    // Send event once on creation
    bloc.add(
      myRole == 'user'
          ? GetUserConsultationRequestStatusEvent()
          : GetAllConsultationRequestStatusEvent(),
    );
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
      child: BlocBuilder<ConsultationRequestBloc, ConsultationRequestState>(
        builder: (context, state) {
          if (state is ConsultationRequestListLoadedSuccessFully) {
            requests = state.consultationRequest;
            return buildTableContainer();
          } else if (state is ConsultationRequestFail) {
            return Center(child: Text('Error: ${state.errmsg}'));
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table title at the center
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Center(
              child: Text(
                widget.tableTitle,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 8, // قلل المسافة بين الأعمدة
              dataRowHeight: 36, // قلل ارتفاع الصفوف
              headingRowHeight: 40, // قلل ارتفاع صف العنوان
              headingRowColor: MaterialStateProperty.all(
                isLight ? Colors.grey.shade200 : Colors.grey.shade800,
              ),
              columns: [
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text('User', style: TextStyle(color: textColor)),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 150,
                    child: Text('Subject', style: TextStyle(color: textColor)),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text('Status', style: TextStyle(color: textColor)),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text('Date', style: TextStyle(color: textColor)),
                  ),
                ),
              ],
              rows: requests.map((req) {
                final statusColor = req.status == 'pending'
                    ? Colors.orange
                    : req.status == 'approved'
                    ? Colors.green
                    : Colors.red;

                return DataRow(
                  cells: [
                    DataCell(
                      SizedBox(
                        width: 100,
                        child: Text(
                          req.user.name,
                          style: TextStyle(color: textColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 150,
                        child: Text(
                          req.subject,
                          style: TextStyle(color: textColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          req.status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 100,
                        child: Text(formatDate(req.date), style: TextStyle(color: textColor)),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
