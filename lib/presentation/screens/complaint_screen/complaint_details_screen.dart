import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../data/models/complaint_model.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../../themes.dart';
import 'update_complaint_screen.dart'; // شاشة تعديل الشكوى

class ComplaintDetailsScreen extends StatefulWidget {
  const ComplaintDetailsScreen({super.key, required this.complaint});
  final ComplaintModel complaint;

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

  Widget _buildInfoRow(IconData icon, String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue.shade900, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: valueColor ?? Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
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
        backgroundColor: Colors.blue.shade50,
        appBar: CustomActionAppBar(title: 'Complaint Details'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade800.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Icon(
                      Icons.report,
                      color: Colors.grey.shade300,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // بيانات الشكوى
                  _buildInfoRow(Icons.description, 'Description', complaint.description),
                  Divider(color: Colors.blue.shade200, thickness: 1.5),
                  _buildInfoRow(
                    Icons.info,
                    'Status',
                    complaint.status,
                    valueColor: complaint.status.toLowerCase() == 'pending'
                        ? Colors.orange
                        : Colors.green,
                  ),
                  Divider(color: Colors.blue.shade200, thickness: 1.5),

                  // بيانات المستخدم
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserLoadedSuccessfully) {
                        final user = state.userModel;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(Icons.person, 'User Name', user.name),
                            Divider(color: Colors.blue.shade200, thickness: 1.5),
                            _buildInfoRow(Icons.email, 'Email', user.email),
                            Divider(color: Colors.blue.shade200, thickness: 1.5),
                            _buildInfoRow(Icons.verified_user, 'Role', user.roleName),
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
            final result = await Navigator.push<ComplaintModel>(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => UserBloc(),
                  child: UpdateComplaintScreen(complaint: complaint),
                ),
              ),
            );

            if (result != null) {
              refreshData(result);
            }
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
          backgroundColor: Colors.blue.shade900,
        ),
      ),
    );
  }
}
