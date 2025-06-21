import 'package:flutter/material.dart';
import '../../../../data/models/issues_model.dart';

class EditIssueScreen extends StatefulWidget {
  final IssuesModel issue;
  const EditIssueScreen({super.key, required this.issue});

  @override
  State<EditIssueScreen> createState() => _EditIssueScreenState();
}

class _EditIssueScreenState extends State<EditIssueScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController issuenumberController;
  late TextEditingController categoryController;
  late TextEditingController courtnameController;
  late TextEditingController statusController;
  late TextEditingController priorityController;
  late TextEditingController startdateController;
  late TextEditingController enddateController;
  late TextEditingController totalcostController;
  late TextEditingController numberofpaymentsController;
  late TextEditingController opponentnameController;
  final Color customColor = const Color(0xFF472A0C);

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.issue.title);
    issuenumberController =
        TextEditingController(text: widget.issue.issueNumber);
    categoryController = TextEditingController(text: widget.issue.category);
    courtnameController = TextEditingController(text: widget.issue.courtName);
    statusController = TextEditingController(text: widget.issue.status);
    priorityController = TextEditingController(text: widget.issue.priority);
    startdateController = TextEditingController(text: widget.issue.startDate);
    // enddateController = TextEditingController(text: widget.issue.endDate);
    totalcostController = TextEditingController(text: widget.issue.totalCost);
    numberofpaymentsController =
        TextEditingController(text: widget.issue.numberOfPayments.toString());
    opponentnameController =
        TextEditingController(text: widget.issue.opponentName);
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) =>
          value!.isEmpty ? 'This field cannot be empty' : null,
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a certificate file")),
      );
      Navigator.pop(context);

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        title:
            const Text("Edit Profile", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Specialization", titleController),
              const SizedBox(height: 15),
              _buildTextField("License Number", issuenumberController),
              const SizedBox(height: 15),
              _buildTextField("License Number", categoryController),
              const SizedBox(height: 15),
              _buildTextField("License Number", courtnameController),
              const SizedBox(height: 15),
              _buildTextField("License Number", statusController),
              const SizedBox(height: 15),
              _buildTextField("License Number", priorityController),
              const SizedBox(height: 15),
              _buildTextField("License Number", startdateController),
              const SizedBox(height: 15),
              _buildTextField("License Number", enddateController),
              const SizedBox(height: 15),
              _buildTextField("License Number", totalcostController),
              const SizedBox(height: 15),
              _buildTextField("License Number", numberofpaymentsController),
              const SizedBox(height: 15),
              _buildTextField("License Number", opponentnameController),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(backgroundColor: customColor),
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    issuenumberController.dispose();
    categoryController.dispose();
    courtnameController.dispose();
    statusController.dispose();
    priorityController.dispose();
    startdateController.dispose();
    enddateController.dispose();
    totalcostController.dispose();
    numberofpaymentsController.dispose();
    super.dispose();
  }
}
