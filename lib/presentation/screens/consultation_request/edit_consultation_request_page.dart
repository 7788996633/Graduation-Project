import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/consultation_request_bloc/consultation_request_bloc.dart';
import '../../../data/models/cons_req_model.dart';

class EditConsultationPage extends StatefulWidget {
  final ConsReqModel request;

  const EditConsultationPage({super.key, required this.request});

  @override
  State<EditConsultationPage> createState() => _EditConsultationPageState();
}

class _EditConsultationPageState extends State<EditConsultationPage> {
  late TextEditingController _subjectController;
  late TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(text: widget.request.subject);
    _detailsController = TextEditingController(text: widget.request.details);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل الاستشارة"),
        backgroundColor: Colors.brown,
      ),
      body: BlocConsumer<ConsultationRequestBloc, ConsultationRequestState>(
        listener: (context, state) {
          if (state is ConsultationRequestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("✅ ${state.successmsg}")),
            );
            Navigator.pop(context);
          } else if (state is ConsultationRequestFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ ${state.errmsg}")),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _subjectController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: 'موضوع الاستشارة',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _detailsController,
                  maxLines: 4,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: 'وصف الاستشارة',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24),
                state is ConsultationRequestLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          final subject = _subjectController.text.trim();
                          BlocProvider.of<ConsultationRequestBloc>(context)
                              .add(
                            UpdateConsultationRequestEvent(
                              id: widget.request.id,
                              subject: subject,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'حفظ التعديلات',
                          style: TextStyle(color: Colors.white),
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
