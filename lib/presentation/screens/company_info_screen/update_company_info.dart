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

  bool _isSaving = false;
  bool _hasRequestedFetch = false;

  @override
  void initState() {
    super.initState();
    final company = widget.companyInfo.company;
    _nameController = TextEditingController(text: company.name);
    _addressController = TextEditingController(text: company.address);
    _descriptionController = TextEditingController(text: company.description);
    _goalsController = TextEditingController(text: company.goals);
    _visionController = TextEditingController(text: company.vision);

    // تحويل foundationDate من String إلى DateTime
    if (company.foundationDate.isNotEmpty) {
      _foundationDate = DateTime.tryParse(company.foundationDate);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _goalsController.dispose();
    _visionController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      if (_foundationDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select foundation date'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isSaving = true;
        _hasRequestedFetch = false;
      });

      BlocProvider.of<CompanyInfoBloc>(context).add(
        UpdateCompanyEvent(

          name: _nameController.text.trim(),
          address: _addressController.text.trim(),
          description: _descriptionController.text.trim(),
          goals: _goalsController.text.trim(),
          vision: _visionController.text.trim(),
          foundationDate: _foundationDate!,
        ),
      );
    }
  }

  Future<void> _pickFoundationDate() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomActionAppBar(title: 'Update Company Info'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<CompanyInfoBloc, CompanyInfoState>(
          listener: (context, state) {
            if (state is CompanyInfoSuccess && !_hasRequestedFetch) {
              _hasRequestedFetch = true;
              BlocProvider.of<CompanyInfoBloc>(context).add(GetCompanyEvent());
            } else if (state is CompanyInfoLoaded) {
              setState(() {
                _isSaving = false;
              });
              Navigator.pop(context, state.company);
            } else if (state is CompanyInfoFail) {
              setState(() {
                _isSaving = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMsg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter company name';
                        }
                        return null;
                      },
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _goalsController,
                      decoration: const InputDecoration(
                        labelText: 'Goals',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter goals';
                        }
                        return null;
                      },
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _visionController,
                      decoration: const InputDecoration(
                        labelText: 'Vision',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter vision';
                        }
                        return null;
                      },
                      enabled: !_isSaving,
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: _isSaving ? null : _pickFoundationDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Foundation Date',
                          border: OutlineInputBorder(),
                        ),
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
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _submitUpdate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkBlue,
                        ),
                        child: _isSaving
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
