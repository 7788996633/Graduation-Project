import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_event.dart';
import '../../../blocs/complaints_bloc/complaint_state.dart';
import '../../../data/models/complaint_model.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../../themes.dart';

class UpdateComplaintScreen extends StatefulWidget {
  final ComplaintModel complaint;

  const UpdateComplaintScreen({super.key, required this.complaint});

  @override
  State<UpdateComplaintScreen> createState() => _UpdateComplaintScreenState();
}

class _UpdateComplaintScreenState extends State<UpdateComplaintScreen> {
  late TextEditingController _descriptionController;
  late ComplaintBloc _bloc;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.complaint.description);
    _bloc = ComplaintBloc();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    if (_descriptionController.text.trim().isEmpty) return;

    _bloc.add(UpdateComplaintEvent(
      complaintId: widget.complaint.id,
      description: _descriptionController.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Complaint'),
        body: BlocConsumer<ComplaintBloc, ComplaintState>(
          listener: (context, state) {
            if (state is ComplaintSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );

              Navigator.pop(
                context,
                ComplaintModel(
                  id: widget.complaint.id,
                  description: _descriptionController.text.trim(),
                  status: widget.complaint.status,
                  userId: widget.complaint.userId,
                ),
              );
            } else if (state is ComplaintFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
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
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Complaint',
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
