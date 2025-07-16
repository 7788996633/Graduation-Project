import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../../../blocs/hiring_requests/hiring_requests_state.dart';
import '../../../widgets/build_custom_appbar_detials.dart';
import '../../../widgets/custom_text_field_add.dart';
import '../../../widgets/elevated_button_submit.dart';

class SetSalaryLawyerScreen extends StatefulWidget {
  final int lawyerId;

  const SetSalaryLawyerScreen({super.key,required this.lawyerId,});

  @override
  State<SetSalaryLawyerScreen> createState() => _SetSalaryLawyerScreenState();
}

class _SetSalaryLawyerScreenState extends State<SetSalaryLawyerScreen> {
  final TextEditingController _salaryController = TextEditingController();

  void _clearFields() {
    _salaryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Set Salary Lawyer"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<HiringRequestsBloc, HiringRequestsState>(
          listener: (context, state) {
            if (state is HiringRequestsSuccess) {
              _clearFields();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successmsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is HiringRequestsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errmsg}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Set Salary for Lawyer",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _salaryController,
                      label: 'Salary',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 30),
                    state is HiringRequestsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          if (_salaryController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter the salary."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          BlocProvider.of<HiringRequestsBloc>(context).add(
                            CreateHiringRequestsEvent(
                              jopTitle: "Set Salary",
                              type: _salaryController.text.trim(),
                              description: "",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
