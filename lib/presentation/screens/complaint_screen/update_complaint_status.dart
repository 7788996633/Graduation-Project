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
  State<UpdateComplaintStatusScreen> createState() =>
      _UpdateComplaintStatusScreenState();
}

class _UpdateComplaintStatusScreenState
    extends State<UpdateComplaintStatusScreen> {
  late TextEditingController _statusController;
  late ComplaintBloc _bloc;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController(text: widget.complaint.status);
    _bloc = ComplaintBloc();
  }

  @override
  void dispose() {
    _statusController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    if (_statusController.text.trim().isEmpty) return;

    _bloc.add(UpdateComplaintStatusEvent(
      complaintId: widget.complaint.id,
      status: _statusController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Complaint Status'),
        body: BlocConsumer<ComplaintBloc, ComplaintState>(
          listener: (context, state) {
            if (state is ComplaintSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ ${state.successMsg}'),
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.pop(
                context,
                ComplaintModel(
                  id: widget.complaint.id,
                  description: widget.complaint.description,
                  status: _statusController.text.trim(),
                  userId: widget.complaint.userId,
                ),
              );
            } else if (state is ComplaintFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('❌ ${state.errMsg}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ComplaintLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _statusController,
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: _onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Status',
                      style: TextStyle(color: Colors.white),
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
