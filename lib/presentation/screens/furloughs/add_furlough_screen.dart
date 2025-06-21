import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_state.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';
import 'package:intl/intl.dart';

class AddFurloughScreen extends StatefulWidget {
  const AddFurloughScreen({super.key});

  @override
  State<AddFurloughScreen> createState() => _AddFurloughScreenState();
}

class _AddFurloughScreenState extends State<AddFurloughScreen> {
  final TextEditingController _causeController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy-MM-dd').format(date) : 'Select Date';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: buildCustomAppBar("Add Furlough"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<FurloughRequestsBloc, FurloughRequestsState>(
          listener: (context, state) {
            if (state is FurloughRequestsSuccess) {
              _causeController.clear();
              setState(() {
                _startDate = null;
                _endDate = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successmsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is FurloughRequestsFail) {
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
                      "Create New Furlough",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFieldAdd(
                      controller: _causeController,
                      label: 'Cause',
                    ),
                    const SizedBox(height: 20),

                    // Start Date
                    GestureDetector(
                      onTap: () => _pickDate(context, true),
                      child: AbsorbPointer(
                        child: CustomTextFieldAdd(
                          controller: TextEditingController(text: _formatDate(_startDate)),
                          label: 'Start Date',
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // End Date
                    GestureDetector(
                      onTap: () => _pickDate(context, false),
                      child: AbsorbPointer(
                        child: CustomTextFieldAdd(
                          controller: TextEditingController(text: _formatDate(_endDate)),
                          label: 'End Date',
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                    state is FurloughRequestsLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          if (_startDate == null || _endDate == null || _causeController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill all fields and select dates."),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          BlocProvider.of<FurloughRequestsBloc>(context).add(
                            CreateFurloughRequestsEvent(
                              cause: _causeController.text,
                              startDate: _formatDate(_startDate),
                              endDate: _formatDate(_endDate),
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
