import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../../blocs/user_bloc/user_bloc.dart';
import '../../../widgets/clients_list.dart';
import '../../../widgets/custom_appbar_add.dart';

class CreateIssueScreen extends StatefulWidget {
  const CreateIssueScreen({super.key});

  @override
  State<CreateIssueScreen> createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController issuenumberController = TextEditingController();
  final TextEditingController courtnameController = TextEditingController();
  final TextEditingController totalcostController = TextEditingController();
  final TextEditingController numberofpaymentsController = TextEditingController();
  final TextEditingController opponentnameController = TextEditingController();

  // Dropdown values
  final List<String> categories = ['Civil', 'Criminal', 'Commercial', 'Other'];
  final List<String> statuses = ['Open', 'Closed', 'Pending', 'In Progress'];
  final List<String> priorities = ['Low', 'Medium', 'High', 'Urgent'];

  String? selectedCategory;
  String? selectedStatus;
  String? selectedPriority;

  // Dates
  DateTime? startDate;
  DateTime? endDate;

  // Selected client userId
  int? selectedUserId;

  int _currentStep = 0;

  final Color mainColor = const Color(0xFF0052CC);
  final Color accentColor = const Color(0xFF00C853);
  final Color backgroundColor = const Color(0xFFF4F7FC);

  @override
  void dispose() {
    titleController.dispose();
    issuenumberController.dispose();
    courtnameController.dispose();
    totalcostController.dispose();
    numberofpaymentsController.dispose();
    opponentnameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (startDate ?? initialDate) : (endDate ?? initialDate),
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
          // Ensure endDate is not before startDate
          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = startDate;
          }
        } else {
          endDate = pickedDate;
          // Ensure endDate is not before startDate
          if (startDate != null && endDate!.isBefore(startDate!)) {
            startDate = endDate;
          }
        }
      });
    }
  }

  String? _validateRequiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void _onStepContinue() {
    if (_currentStep == 2) {
      // Final step - validate whole form and submit
      if (_formKey.currentState?.validate() ?? false) {
        if (selectedUserId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select a client."),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }
        if (startDate == null || endDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select start and end dates."),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }
        if (selectedCategory == null || selectedStatus == null || selectedPriority == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select category, status, and priority."),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }

        BlocProvider.of<IssuesBloc>(context).add(IssueAdd(
          amoountPaid: int.tryParse(numberofpaymentsController.text) ?? 0,
          description: titleController.text,
          userId: selectedUserId!,
          title: titleController.text,
          issueNumber: issuenumberController.text,
          category: selectedCategory!,
          courtName: courtnameController.text,
          status: selectedStatus!,
          priority: selectedPriority!,
          startDate: startDate!.toIso8601String(),
          endDate: endDate!.toIso8601String(),
          totalCost: totalcostController.text,
          numberOfPayments: int.tryParse(numberofpaymentsController.text) ?? 0,
          opponentName: opponentnameController.text,
        ));
      }
    } else {
      setState(() {
        _currentStep += 1;
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep == 0) return;
    setState(() {
      _currentStep -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomActionAppBar(
        title: 'Create Issue',
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: _onStepContinue,
            onStepCancel: _onStepCancel,
            controlsBuilder: (context, details) {
              final isLastStep = _currentStep == 2;
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: Text(isLastStep ? 'Submit' : 'Next', style: const TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 20),
                  if (_currentStep > 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text("Back", style: TextStyle(fontSize: 16)),
                    ),
                ],
              );
            },
            steps: [
              Step(
                isActive: _currentStep >= 0,
                state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                title: const Text('Basic Info'),
                content: Column(
                  children: [
                    _buildTextField(
                      controller: titleController,
                      label: 'Title',
                      icon: Icons.title,
                    ),
                    _buildTextField(
                      controller: issuenumberController,
                      label: 'Issue Number',
                      icon: Icons.confirmation_number_outlined,
                      inputType: TextInputType.number,
                    ),
                    _buildTextField(
                      controller: courtnameController,
                      label: 'Court Name',
                      icon: Icons.account_balance,
                    ),
                    const SizedBox(height: 10),
                    _buildDropdown(
                      label: 'Category',
                      value: selectedCategory,
                      items: categories,
                      onChanged: (val) => setState(() => selectedCategory = val),
                    ),
                    const SizedBox(height: 10),
                    _buildDropdown(
                      label: 'Status',
                      value: selectedStatus,
                      items: statuses,
                      onChanged: (val) => setState(() => selectedStatus = val),
                    ),
                    const SizedBox(height: 10),
                    _buildDropdown(
                      label: 'Priority',
                      value: selectedPriority,
                      items: priorities,
                      onChanged: (val) => setState(() => selectedPriority = val),
                    ),
                  ],
                ),
              ),
              Step(
                isActive: _currentStep >= 1,
                state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                title: const Text('Dates & Costs'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDatePicker(
                      label: 'Start Date',
                      selectedDate: startDate,
                      onTap: () => _pickDate(context, true),
                    ),
                    const SizedBox(height: 12),
                    _buildDatePicker(
                      label: 'End Date',
                      selectedDate: endDate,
                      onTap: () => _pickDate(context, false),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: totalcostController,
                      label: 'Total Cost',
                      icon: Icons.monetization_on_outlined,
                      inputType: TextInputType.number,
                    ),
                    _buildTextField(
                      controller: numberofpaymentsController,
                      label: 'Number of Payments',
                      icon: Icons.payments_outlined,
                      inputType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              Step(
                isActive: _currentStep >= 2,
                title: const Text('Client & Opponent'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select a Client:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      height: 150,
                      child: BlocProvider(
                        create: (context) => UserBloc(),
                        child: ClientsList(
                          onUserSelected: (userId) {
                            setState(() {
                              selectedUserId = userId;
                            });
                          },
                        ),

                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: opponentnameController,
                      label: 'Opponent Name',
                      icon: Icons.person_outline,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      validator: _validateRequiredField,
      cursorColor: mainColor,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: mainColor) : null,
        labelText: label,
        labelStyle: TextStyle(color: mainColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: mainColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: mainColor.withOpacity(0.7)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text('Select $label'),
          icon: Icon(Icons.arrow_drop_down, color: mainColor),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        ),
        child: Text(
          selectedDate == null
              ? 'Select Date'
              : "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}",
          style: TextStyle(
            fontSize: 16,
            color: selectedDate == null ? Colors.grey : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
