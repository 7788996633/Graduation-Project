import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/company_info_bloc/company_info_bloc.dart';
import '../../../blocs/company_info_bloc/company_info_event.dart';
import '../../../blocs/company_info_bloc/company_info_state.dart';
import '../../../data/models/company_info_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import 'update_company_info.dart';

class CompanyInfoDetailsScreen extends StatefulWidget {


  const CompanyInfoDetailsScreen({super.key});

  @override
  State<CompanyInfoDetailsScreen> createState() =>
      _CompanyInfoDetailsScreenState();
}

class _CompanyInfoDetailsScreenState extends State<CompanyInfoDetailsScreen> {
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
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
  void initState() {
    super.initState();
    BlocProvider.of<CompanyInfoBloc>(context).add(GetCompanyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: const CustomActionAppBar(
        title: 'Company Info Details',
      ),
      body: BlocBuilder<CompanyInfoBloc, CompanyInfoState>(
        builder: (context, state) {
          if (state is CompanyInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyInfoLoaded) {
            final companyInfo = state.company;
            final company = companyInfo.company;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== بطاقة بيانات الشركة =====
                  Card(
                    elevation: 12,
                    shadowColor: Colors.deepPurple.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Icon(
                              Icons.business_outlined,
                              size: 80,
                              color: AppColors.darkBlue,
                              shadows: [
                                Shadow(
                                  color: Colors.blueAccent.shade200
                                      .withOpacity(0.6),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildInfoRow('ID', company.id.toString()),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Name', company.name),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Address', company.address),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Foundation Date', company.foundationDate),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Description', company.description),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Goals', company.goals),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Vision', company.vision),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Created At', company.createdAt),
                          Divider(
                              color: Colors.deepPurple.shade100, thickness: 1.5),
                          _buildInfoRow('Updated At', company.updatedAt),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CompanyInfoFail) {
            return Center(child: Text('Error: ${state.errorMsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: BlocBuilder<CompanyInfoBloc, CompanyInfoState>(
        builder: (context, state) {
          if (state is CompanyInfoLoaded) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push<CompanyInfoModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => CompanyInfoBloc(),
                      child: UpdateCompanyInfoScreen(
                        companyInfo: state.company,
                      ),
                    ),
                  ),
                );

                if (result != null) {
                  BlocProvider.of<CompanyInfoBloc>(context)
                      .add(GetCompanyEvent());
                }
              },
              icon: const Icon(Icons.edit),
              label: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkBlue,
              elevation: 6,
              hoverElevation: 12,
              extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
