import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../blocs/consultations_bloc/consultation_bloc.dart';
import '../../../constant.dart';
import '../../../data/models/cons_req_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_text_field.dart';
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
    consultationBloc.add(GetConsultationsByRequestIdEvent(
        reqId: widget.consultationRequestModel.id));
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
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: AppBar(
        backgroundColor: getCurrentTheme()['AppBar'],
        title: Text(
          widget.consultationRequestModel.user.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
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
                  icon: const Icon(
                    Icons.edit,
                  ),
                )
              : const SizedBox(
                  width: 0,
                ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      40,
                    ),
                  ),
                  child: Image.network(
                    height: 200,
                    fit: BoxFit.fill,
                    widget.consultationRequestModel.user.profileModel.image,
                  ),
                ),
                Text(
                  widget.consultationRequestModel.user.name,
                  style: TextStyle(
                    color: getCurrentTheme()['NormalText'],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: getCurrentTheme()['Border']!,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.consultationRequestModel.subject,
                        style: TextStyle(
                            color: getCurrentTheme()['NormalText'],
                            fontSize: 18),
                      ),
                      Text(
                        widget.consultationRequestModel.details,
                        style: TextStyle(
                            color: getCurrentTheme()['NormalText'],
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<ConsultationBloc, ConsultationState>(
                builder: (context, state) {
                  if (state is ConsultationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ConsultationFail) {
                    return Center(child: Text('خطأ: ${state.errmsg}'));
                  } else if (state is ConsultationsListLoadedSuccessfully) {
                    final consultations = state.consultations;

                    if (true) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: consultations.length,
                              itemBuilder: (context, index) {
                                final consultation = consultations[index];
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    title: Text(
                                      consultation.resault,
                                      style: TextStyle(
                                        color: getCurrentTheme()['NormalText'],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if (myRole == 'lawyer' &&
                                widget.consultationRequestModel.status
                                        .toLowerCase() ==
                                    'approved' &&
                                widget.consultationRequestModel.isLocked ==
                                    0) ...[
                              CustomTextFeild(
                                color: Colors.white,
                                text: "Consultation",
                                controller: _resaultController,
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
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: _onSubmit,
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                            ]
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('لا توجد استشارات بعد'),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: consultations.length,
                      itemBuilder: (context, index) {
                        final consultation = consultations[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              consultation.resault,
                              style: TextStyle(
                                color: getCurrentTheme()['NormalText'],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
