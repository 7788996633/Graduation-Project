import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../../blocs/delegations_bloc/delegations_event.dart';
import '../../../blocs/delegations_bloc/delegations_state.dart';
import '../../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../../data/models/delegations_model.dart';
import '../../../data/models/lawyer_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/lawyer_radio_item.dart';

class DelegationDetailsScreen extends StatefulWidget {
  const DelegationDetailsScreen({super.key, required this.delegation});
  final DelegationModel delegation;

  @override
  State<DelegationDetailsScreen> createState() =>
      _DelegationDetailsScreenState();
}

class _DelegationDetailsScreenState extends State<DelegationDetailsScreen> {
  late int selectedLawyerId;
  late int delegatedLawyerId;

  bool isAddingNote = false;
  bool isSelectingLawyer = false;

  List<LawyerModel> lawyers = [];
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedLawyerId = widget.delegation.originalLawyerId;
    delegatedLawyerId =
        widget.delegation.originalLawyerId; // 👈 افتراضياً نفس المحامي الأصلي

    BlocProvider.of<LawyerInIssuesBloc>(context).add(
      GetAllLawyersInIssuesEvent(issueId: widget.delegation.issueId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomActionAppBar(title: 'Delegation Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildStatusCard(widget.delegation.status),
            const SizedBox(height: 15),
            _buildInfoCard(
              icon: Icons.sticky_note_2_outlined,
              title: "Admin Note",
              value: widget.delegation.adminNote ?? "-",
              onTap: () => setState(() => isAddingNote = !isAddingNote),
            ),
            if (isAddingNote) _noteInput(),
            const SizedBox(height: 15),
            _buildInfoCard(
              icon: Icons.insert_drive_file_outlined,
              title: "Delegation File",
              value: widget.delegation.delegationFile ?? "-",
            ),
            const SizedBox(height: 20),
            _selectLawyerSection(),
            const SizedBox(height: 20),
            _actionButtons(),
            const SizedBox(height: 30),
            _attachedFileSection(),
          ],
        ),
      ),
    );
  }

  /// 🟢 كرت الحالة
  Widget _buildStatusCard(String status) {
    Color color;
    IconData icon;
    switch (status.toLowerCase()) {
      case "approved":
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case "rejected":
        color = Colors.red;
        icon = Icons.cancel;
        break;
      default:
        color = Colors.orange;
        icon = Icons.hourglass_empty;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 32),
        title: const Text("Status",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
        subtitle: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
      ),
    );
  }

  /// 🟢 كرت معلومات
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54)),
        subtitle: Text(value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        trailing:
            onTap != null ? const Icon(Icons.edit, color: Colors.grey) : null,
        onTap: onTap,
      ),
    );
  }

  /// 🟢 إدخال الملاحظة
  Widget _noteInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          CustomTextFeild(
            text: "Add note...",
            controller: noteController,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => setState(() => isAddingNote = false),
            child: const Text(
              "Save Note",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  /// 🟢 اختيار محامي جديد
  Widget _selectLawyerSection() {
    return ExpansionTile(
      leading: const Icon(Icons.people_alt, color: Colors.deepPurple),
      title: const Text("Select new lawyer",
          style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        BlocBuilder<LawyerInIssuesBloc, LawyerInIssuesState>(
          builder: (context, state) {
            if (state is LawyerInIssuesListLoadedSuccessfully) {
              lawyers = state.lawyerInissues;
              if (lawyers.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("No lawyers found."),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lawyers.length,
                separatorBuilder: (_, i) => const Divider(),
                itemBuilder: (context, index) {
                  return LawyerRadioItem(
                    lawyerModel: lawyers[index],
                    onChanged: (value) =>
                        setState(() => selectedLawyerId = value!),
                    groupValue: selectedLawyerId,
                  );
                },
              );
            } else if (state is LawyerInIssuesFail) {
              return Text(state.errmsg,
                  style: const TextStyle(color: Colors.red));
            } else {
              return const Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          onPressed: () {
            if (selectedLawyerId == widget.delegation.originalLawyerId) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select a different lawyer"),
                  backgroundColor: Colors.orange,
                ),
              );
              return;
            }
            delegatedLawyerId = selectedLawyerId;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("New lawyer selected successfully"),
                backgroundColor: Colors.blue,
              ),
            );
          },
          child: const Text("Confirm Lawyer",
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  /// 🟢 أزرار الموافقة / الرفض
  Widget _actionButtons() {
    return BlocConsumer<DelegationBloc, DelegationState>(
      listener: (context, state) {
        if (state is DelegationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.successMsg), backgroundColor: Colors.green),
          );
        } else if (state is DelegationFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMsg), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.check, color: Colors.white),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                if (delegatedLawyerId == widget.delegation.originalLawyerId) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "You must choose a different lawyer before approving"),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }
                BlocProvider.of<DelegationBloc>(context).add(
                  AddApproveDelegationEvent(
                    delegationId: widget.delegation.id,
                    adminNote: noteController.text,
                    delegateLawyerId: delegatedLawyerId,
                  ),
                );
              },
              label: const Text("Approve",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.close, color: Colors.white),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () {
                BlocProvider.of<DelegationBloc>(context).add(
                  AddRejectDelegationEvent(
                    delegationId: widget.delegation.id,
                    adminNote: noteController.text,
                    originalLawyerId: widget.delegation.originalLawyerId,
                    sessionId: widget.delegation.issueId,
                  ),
                );
              },
              label: const Text("Reject",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  /// 🟢 الملف المرفق
  Widget _attachedFileSection() {
    if (widget.delegation.delegationFile.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Attached File",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ImageFullScreen(url: widget.delegation.delegationFile),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.delegation.delegationFile,
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  alignment: Alignment.center,
                  child: const Text('Failed to load file',
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Text('No attached file',
          style: TextStyle(
              fontSize: 16, color: Colors.grey, fontStyle: FontStyle.italic));
    }
  }
}

class ImageFullScreen extends StatelessWidget {
  final String url;
  const ImageFullScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black, title: const Text('View Image')),
      body: Center(
        child: InteractiveViewer(child: Image.network(url)),
      ),
    );
  }
}
