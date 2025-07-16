import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/consultation_request_bloc/consultation_request_bloc.dart';
import 'package:graduation/themes.dart';

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
        child: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Consultation subject",
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    validator: Validator.nameValidator,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: subjectController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Enter your consultation subject",
                      prefixIcon: Icon(
                        Icons.title,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Consultation details",
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    validator: Validator.nameValidator,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: detailsController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                      hintText: "Enter your consultation details",
                      prefixIcon: Icon(
                        Icons.post_add_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                BlocConsumer<ConsultationRequestBloc, ConsultationRequestState>(
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
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        fixedSize: Size(
                          400,
                          40,
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<ConsultationRequestBloc>(context).add(
                            AddConsultationRequestEvent(
                              subject: subjectController.text,
                              details: detailsController.text,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }
}
