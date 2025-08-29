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
  late String _selectedStatus;
  late ComplaintBloc _bloc;

  final List<String> _statusOptions = ['pending', 'approved', 'rejected'];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.complaint.status;
    _bloc = ComplaintBloc();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    _bloc.add(UpdateComplaintStatusEvent(
      complaintId: widget.complaint.id,
      status: _selectedStatus,
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
                  status: _selectedStatus,
  date: widget.complaint.date,
                  userName: widget.complaint.userName,
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
                  const Text(
                    'Select Status:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._statusOptions.map(
                        (status) => RadioListTile<String>(
                      title: Text(status),
                      value: status,
                      groupValue: _selectedStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),
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
