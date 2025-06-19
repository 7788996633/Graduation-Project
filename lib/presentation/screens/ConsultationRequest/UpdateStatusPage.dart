import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../data/models/consultation_Request_model.dart';

class UpdateStatusPage extends StatefulWidget {
  final ConsultationRequestModel request;

  const UpdateStatusPage({required this.request});

  @override
  State<UpdateStatusPage> createState() => _UpdateStatusPageState();
}

class _UpdateStatusPageState extends State<UpdateStatusPage> {
  String? selectedStatus;

  final List<String> statusOptions = [
    'قيد المراجعة',
    'تمت الموافقة',
    'مرفوضة',
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.request.status ?? statusOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConsultationRequestBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('تحديث حالة الاستشارة'),
          backgroundColor: Colors.brown,
        ),
        body: BlocConsumer<ConsultationRequestBloc, ConsultationRequestState>(
          listener: (context, state) {
            if (state is ConsultationRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successmsg}')),
              );
              Navigator.pop(context); // الرجوع بعد التحديث
            } else if (state is ConsultationRequestFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errmsg}')),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('الموضوع: ${widget.request.subject ?? 'بدون عنوان'}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('الوصف: ${widget.request.details ?? 'لا يوجد تفاصيل'}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    items: statusOptions.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status, textAlign: TextAlign.right),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'اختر الحالة الجديدة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  state is ConsultationRequestLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      if (selectedStatus != null) {
                        BlocProvider.of<ConsultationRequestBloc>(context).add(
                          UpdateConsultationRequestStatusEvent(
                            id: widget.request.id,
                            status: selectedStatus!,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: Text('تحديث الحالة', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
