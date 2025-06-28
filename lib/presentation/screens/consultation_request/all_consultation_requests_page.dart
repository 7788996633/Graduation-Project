import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/consultation_request_bloc/consultation_request_bloc.dart';

import 'edit_consultation_request_page.dart';


class AllConsultationRequestsPage extends StatelessWidget {
  const AllConsultationRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConsultationRequestBloc()..add(GetAllConsultationRequestStatusEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('جميع الاستشارات القانونية'),
          backgroundColor: Colors.brown,
        ),
        body: BlocConsumer<ConsultationRequestBloc, ConsultationRequestState>(
          listener: (context, state) {
            if (state is ConsultationRequestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("✅ ${state.successmsg}")),
              );
              // إعادة تحميل القائمة بعد الحذف
              BlocProvider.of<ConsultationRequestBloc>(context)
                  .add(GetAllConsultationRequestStatusEvent());
            } else if (state is ConsultationRequestFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("❌ ${state.errmsg}")),
              );
            }
          },
          builder: (context, state) {
            if (state is ConsultationRequestLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ConsultationRequestListLoadedSuccessFully) {
              if (state.consultationRequest.isEmpty) {
                return Center(child: Text("لا توجد استشارات حتى الآن."));
              }
              return ListView.builder(
                itemCount: state.consultationRequest.length,
                itemBuilder: (context, index) {
                  final request = state.consultationRequest[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      title: Text(
                        request.subject,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        request.details,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditConsultationPage(request: request),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("تأكيد الحذف"),
                                  content: Text("هل أنت متأكد من حذف هذه الاستشارة؟"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("إلغاء"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        BlocProvider.of<ConsultationRequestBloc>(context).add(
                                          DeleteConsultationRequestStatusEvent(id: request.id),
                                        );
                                      },
                                      child: Text("نعم، احذف"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ConsultationRequestFail) {
              return Center(
                child: Text('حدث خطأ: ${state.errmsg}'),
              );
            } else {
              return Center(child: Text('جاري التحميل...'));
            }
          },
        ),
      ),
    );
  }
}
