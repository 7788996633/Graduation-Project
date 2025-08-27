import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/user_bloc/user_bloc.dart';

import '../../../constant.dart';
import '../../../data/models/complaint_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../complaint_screen/update_complaint_screen.dart';

import 'update_complaint_status.dart';

class ComplaintDetailsScreen extends StatefulWidget {
  const ComplaintDetailsScreen({
    super.key,
    required this.complaint,
    required this.myRole, // أضف هذا
  });

  final ComplaintModel complaint;
  final String myRole; // تعريف المتغير

  @override
  State<ComplaintDetailsScreen> createState() => _ComplaintDetailsScreenState();
}

class _ComplaintDetailsScreenState extends State<ComplaintDetailsScreen> {
  late ComplaintModel complaint;

  @override
  void initState() {
    super.initState();
    complaint = widget.complaint;
  }

  void refreshData(ComplaintModel updated) {
    setState(() {
      complaint = updated;
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: valueColor ?? Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc()..add(GetUserById(userId: complaint.userId)),
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: const CustomActionAppBar(title: 'Complaint Details'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 10,
            color: Colors.white,
            shadowColor: Colors.blueGrey.shade100,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child:
                    Icon(Icons.report, size: 72, color: AppColors.darkBlue),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow(
                    icon: Icons.description,
                    label: 'Description',
                    value: complaint.description,
                  ),
                  _buildInfoRow(
                    icon: Icons.info,
                    label: 'Status',
                    value: complaint.status,
                    valueColor: complaint.status.toLowerCase() == 'pending'
                        ? Colors.orange
                        : Colors.green,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserLoadedSuccessfully) {
                        final user = state.userModel;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                icon: Icons.person,
                                label: 'User Name',
                                value: user.name),
                            _buildInfoRow(
                                icon: Icons.email,
                                label: 'Email',
                                value: user.email),
                          ],
                        );
                      } else if (state is UserFail) {
                        return Text(
                          "Failed to load user: ${state.errmsg}",
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // تحديد الشاشة حسب الدور
            final result = await Navigator.push<ComplaintModel>(
              context,
              MaterialPageRoute(
                builder: (_) => widget.myRole != null &&
                    widget.myRole!.toLowerCase() == 'admin'
                    ? UpdateComplaintStatusScreen(complaint: complaint)
                    : UpdateComplaintScreen(complaint: complaint),
              ),
            );

            if (result != null) {
              refreshData(result);
            }
          },
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text(
            'Edit',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: AppColors.darkBlue,
        ),
      ),
    );
  }
}
