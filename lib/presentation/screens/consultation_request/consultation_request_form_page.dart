import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/screens/consultation_request/all_consultation_requests_page.dart';

import '../../../blocs/consultation_request_bloc/consultation_request_bloc.dart';

class ConsultationFormPage extends StatefulWidget {
  const ConsultationFormPage({super.key});

  @override
  State<ConsultationFormPage> createState() => _ConsultationFormPageState();
}

class _ConsultationFormPageState extends State<ConsultationFormPage> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConsultationRequestBloc(),
      child: Scaffold(
        backgroundColor: Color(0xFF6B6840),
        body: SafeArea(
          child: Center(
            child: Container(
              width: 300,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: BlocConsumer<ConsultationRequestBloc, ConsultationRequestState>(
                listener: (context, state) {
                  if (state is ConsultationRequestSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("✅ ${state.successmsg}")),
                    );
                  } else if (state is ConsultationRequestFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("❌ ${state.errmsg}")),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'طلب استشارة قانونية',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[800],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _subjectController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          labelText: 'موضوع الاستشارة :',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _detailsController,
                        textAlign: TextAlign.right,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: 'وصف الاستشارة بالتفصيل:',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 12),

                      SizedBox(height: 16),
                      state is ConsultationRequestLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: () {
                          final subject = _subjectController.text.trim();
                          final details = _detailsController.text.trim();
                          if (subject.isNotEmpty && details.isNotEmpty) {
                            BlocProvider.of<ConsultationRequestBloc>(context).add(
                              AddConsultationRequestEvent(
                             subject: subject,
                                details: details,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("الرجاء تعبئة جميع الحقول")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        ),
                        onLongPress:  () { Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => ConsultationRequestBloc(),
                              child:  AllConsultationRequestsPage(),
                            ),
                          ),
                        );},
                        child: Text(
                          'ارسال الطلب',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
