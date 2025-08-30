import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/presentation/widgets/custom_text_field.dart';
import 'package:graduation/responsive.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../themes.dart';
import '../../../validator.dart';

class SubmitConsultationRequestScreen extends StatefulWidget {
  const SubmitConsultationRequestScreen({super.key});

  @override
  State<SubmitConsultationRequestScreen> createState() =>
      _SubmitConsultationRequestScreenState();
}

class _SubmitConsultationRequestScreenState
    extends State<SubmitConsultationRequestScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        leadingWidth: 30,
        backgroundColor: AppColors.darkBlue,
        title: Text(
          "Submit your consultation request",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: s20, vertical: s20),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 2,
                  colors: isLight.value
                      ? [
                          AppColors.darkBlue,
                          AppColors.softGray,
                          AppColors.white,
                        ]
                      : [
                          Colors.black,
                          AppColors.softGray,
                          AppColors.white,
                        ],
                ),
                border: Border.all(
                  strokeAlign: 2,
                  width: 3,
                  color: AppColors.white,
                ),
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Consultation subject",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFeild(
                    color: Colors.white,
                    text: 'Enter your consultation subject',
                    validator: Validator.nameValidator,
                    controller: subjectController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Consultation details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFeild(
                    validator: Validator.nameValidator,
                    color: Colors.white,
                    text: 'Enter your consultation details',
                    controller: detailsController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<ConsultationRequestBloc,
                      ConsultationRequestState>(
                    listener: (context, state) async {
                      if (state is ConsultationRequestSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('✅ ${state.successmsg}')),
                        );
                        await Future.delayed(
                          Duration(
                            milliseconds: 500,
                          ),
                        );

                        Navigator.pop(context);
                      } else if (state is ConsultationRequestFail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('❌ ${state.errmsg}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<ConsultationRequestBloc>(context)
                                  .add(
                                AddConsultationRequestEvent(
                                  subject: subjectController.text,
                                  details: detailsController.text,
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
