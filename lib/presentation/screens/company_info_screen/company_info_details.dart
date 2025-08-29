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
  final CompanyInfoModel? companyInfo; // الآن يمكن أن يكون null

  const CompanyInfoDetailsScreen({super.key, this.companyInfo});

  @override
  State<CompanyInfoDetailsScreen> createState() =>
      _CompanyInfoDetailsScreenState();
}

class _CompanyInfoDetailsScreenState extends State<CompanyInfoDetailsScreen> {
  CompanyInfoModel? info;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    info = widget.companyInfo;

    if (info == null) {
      // إذا لم يتم تمرير معلومات الشركة، نحملها من Bloc
      final bloc = context.read<CompanyInfoBloc>();
      bloc.add(GetCompanyEvent());
      isLoading = true;
    }
  }

  void refreshData(CompanyInfoModel updated) {
    setState(() {
      info = updated;
    });
  }

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
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 12),
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
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: const CustomActionAppBar(
        title: 'Company Info Details',
      ),
      body: BlocConsumer<CompanyInfoBloc, CompanyInfoState>(
        listener: (context, state) {
          if (state is CompanyInfoLoaded) {
            setState(() {
              info = state.company;
              isLoading = false;
            });
          } else if (state is CompanyInfoFail) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        builder: (context, state) {
          if (info == null || isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final company = info!.company;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 12,
              shadowColor: Colors.deepPurple.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        Icons.business_outlined,
                        size: 80,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildInfoRow('Name', company.name),
                    _buildInfoRow('Address', company.address),
                    _buildInfoRow('Foundation Date', company.foundationDate),
                    _buildInfoRow('Description', company.description),
                    _buildInfoRow('Goals', company.goals),
                    _buildInfoRow('Vision', company.vision),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (info == null) return;

          final updatedInfo = await Navigator.push<CompanyInfoModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<CompanyInfoBloc>(),
                child: UpdateCompanyInfoScreen(companyInfo: info!),
              ),
            ),
          );

          if (updatedInfo != null) {
            refreshData(updatedInfo);
          }
        },
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          'Edit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
    );
  }
}
