import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../blocs/consultations_bloc/consultation_bloc.dart';
import '../../../constant.dart';
import '../../../data/models/cons_req_model.dart';
import '../consultation_request/edit_consultation_request_page.dart';

class AddConsultationScreen extends StatefulWidget {
  final ConsReqModel consultationRequestModel;

  const AddConsultationScreen({
    super.key,
    required this.consultationRequestModel,
  });

  @override
  State<AddConsultationScreen> createState() => _AddConsultationScreenState();
}

class _AddConsultationScreenState extends State<AddConsultationScreen> {
  final TextEditingController _resaultController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late ConsultationBloc consultationBloc;
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final resault = _resaultController.text.trim();

      consultationBloc.add(
        AddConsultationEvent(
          resault: resault,
          consultationRequestId: widget.consultationRequestModel.id,
        ),
      );
    }
  }

  @override
  void initState() {
    consultationBloc = BlocProvider.of<ConsultationBloc>(context);
    if (myRole == 'lawyer') {
      consultationBloc.add(
        StartConsultationRequestReview(
          consultationRequestId: widget.consultationRequestModel.id,
        ),
      );
    }
    super.initState();
    print("startreview");
  }

  @override
  void dispose() {
    _resaultController.dispose();
    if (myRole == 'lawyer') {
      consultationBloc.add(
        EndConsultationRequestReview(
          consultationRequestId: widget.consultationRequestModel.id,
        ),
      );
    }
    print("endreview");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة استشارة'),
        actions: [
          myUserId == widget.consultationRequestModel.user.id &&
                  widget.consultationRequestModel.isLocked == 0
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) => ConsultationRequestBloc(),
                          child: EditConsultationPage(
                            request: widget.consultationRequestModel,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                  ),
                )
              : SizedBox(
                  width: 0,
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget
                              .consultationRequestModel.user.profileModel!.image,
                        ),
                      ),
                      Text(
                        widget.consultationRequestModel.user.name,
                      ),
                    ],
                  ),
                  Text(
                    widget.consultationRequestModel.subject,
                  ),
                  Text(
                    widget.consultationRequestModel.details,
                  ),
                ],
              ),
            ),
            BlocConsumer<ConsultationBloc, ConsultationState>(
              listener: (context, state) {
                print('locked ${widget.consultationRequestModel.isLocked}');
                if (state is ConsultationSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.successmsg)),
                  );
                } else if (state is ConsultationFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('خطأ: ${state.errmsg}'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _resaultController,
                        decoration: const InputDecoration(
                          labelText: 'نتيجة الاستشارة',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال نتيجة الاستشارة';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      state is ConsultationLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _onSubmit,
                              child: const Text('إرسال'),
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
  }
}
