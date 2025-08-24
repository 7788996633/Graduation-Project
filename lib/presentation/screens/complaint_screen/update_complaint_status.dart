import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_event.dart';
import '../../../blocs/complaints_bloc/complaint_state.dart';
import '../../../data/models/complaint_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateComplaintStatusScreen extends StatefulWidget {
  final ComplaintModel complaint;

  const UpdateComplaintStatusScreen({super.key, required this.complaint});

  @override
  State<UpdateComplaintStatusScreen> createState() => _UpdateComplaintStatusScreenState();
}

class _UpdateComplaintStatusScreenState extends State<UpdateComplaintStatusScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController(text: widget.complaint.status);
  }

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Update Complaint Status',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<ComplaintBloc, ComplaintState>(
          listener: (context, state) {
            if (state is ComplaintSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.successMsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(
                context,
                ComplaintModel(
                  id: widget.complaint.id,
                  description: widget.complaint.description,
                  status: _statusController.text.trim(), userId: widget.complaint.userId,
                ),
              );
            } else if (state is ComplaintFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errMsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ComplaintLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Loading ...",
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.grey,
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
                    controller: _statusController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Status'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter status' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<ComplaintBloc>(context).add(
                          UpdateComplaintStatusEvent (
                            complaintId: widget.complaint.id,

                            status: _statusController.text.trim(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
