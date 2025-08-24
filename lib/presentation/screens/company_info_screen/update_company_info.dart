import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/company_info_bloc/company_info_bloc.dart';
import '../../../blocs/company_info_bloc/company_info_event.dart';
import '../../../blocs/company_info_bloc/company_info_state.dart';
import '../../../data/models/company_info_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateCompanyInfoScreen extends StatefulWidget {
  final CompanyInfoModel companyInfo;

  const UpdateCompanyInfoScreen({super.key, required this.companyInfo});

  @override
  State<UpdateCompanyInfoScreen> createState() => _UpdateCompanyInfoScreenState();
}

class _UpdateCompanyInfoScreenState extends State<UpdateCompanyInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _descriptionController;
  late TextEditingController _goalsController;
  late TextEditingController _visionController;

  DateTime? _foundationDate;

  late CompanyInfoBloc _bloc;

  @override
  void initState() {
    super.initState();
    final company = widget.companyInfo.company;
    _nameController = TextEditingController(text: company.name);
    _addressController = TextEditingController(text: company.address);
    _descriptionController = TextEditingController(text: company.description);
    _goalsController = TextEditingController(text: company.goals);
    _visionController = TextEditingController(text: company.vision);

    if (company.foundationDate.isNotEmpty) {
      _foundationDate = DateTime.tryParse(company.foundationDate);
    }

    _bloc = CompanyInfoBloc();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _goalsController.dispose();
    _visionController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _pickFoundationDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _foundationDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _foundationDate = pickedDate;
      });
    }
  }

  void _onUpdatePressed() {
    if (_formKey.currentState!.validate() && _foundationDate != null) {
      _bloc.add(UpdateCompanyEvent(
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        description: _descriptionController.text.trim(),
        goals: _goalsController.text.trim(),
        vision: _visionController.text.trim(),
        foundationDate: _foundationDate!,
      ));
    } else if (_foundationDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select foundation date'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompanyInfoBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Company Info'),
        body: BlocConsumer<CompanyInfoBloc, CompanyInfoState>(
          listener: (context, state) {
            if (state is CompanyInfoLoaded) {
              Navigator.pop(
                context,
                state.company,
              );
            } else if (state is CompanyInfoFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errorMsg}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is CompanyInfoLoading;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: 'Address'),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _goalsController,
                        decoration: const InputDecoration(labelText: 'Goals'),
                        maxLines: 2,
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _visionController,
                        decoration: const InputDecoration(labelText: 'Vision'),
                        maxLines: 2,
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: isLoading ? null : _pickFoundationDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(labelText: 'Foundation Date'),
                          child: Text(
                            _foundationDate != null
                                ? "${_foundationDate!.year}-${_foundationDate!.month.toString().padLeft(2,'0')}-${_foundationDate!.day.toString().padLeft(2,'0')}"
                                : 'Select Date',
                            style: TextStyle(
                              fontSize: 16,
                              color: _foundationDate != null
                                  ? Colors.black87
                                  : Colors.grey.shade600,
                            ),
                          ),
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
                          'Update',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
