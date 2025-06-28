import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled27/presentation/screens/furloughs/update_furloughs_screen.dart';
import 'package:untitled27/presentation/screens/furloughs/update_furloughs_status_screen.dart';

import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../constant.dart';
import '../../../data/models/furlough_request_model.dart';
import '../../widgets/custom_appbar_add.dart';

class FurloughDetailsScreen extends StatefulWidget {
  const FurloughDetailsScreen({super.key, required this.furloughModel});
  final FurloughRequestModel furloughModel;

  @override
  State<FurloughDetailsScreen> createState() => _FurloughDetailsScreenState();
}

class _FurloughDetailsScreenState extends State<FurloughDetailsScreen> {
  late FurloughRequestModel furlough;

  @override
  void initState() {
    super.initState();
    furlough = widget.furloughModel;
  }

  void refreshData(FurloughRequestModel updated) {
    setState(() {
      furlough = updated;
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
  Widget build(BuildContext context) {
    // خذ التوكن من مصدره الحقيقي عندك (storage، provider، bloc...)
    String myToken = 'user'; // مثلاً، بدّل حسب وضعك

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Furlough Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 12,
          shadowColor: Colors.deepPurple.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.beach_access_outlined,
                    size: 80,
                    color: AppColors.darkBlue,
                    shadows: [
                      Shadow(
                        color: Colors.blueAccent.shade200.withOpacity(0.6),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoRow('ID', furlough.id.toString()),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Start Date', furlough.startDate.toString()),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('End Date', furlough.endDate.toString()),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Cause', furlough.cause),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Status', furlough.status, valueColor: AppColors.darkBlue),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Requested By Type', furlough.covetByType),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Requested By ID', furlough.covetById.toString()),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          FurloughRequestModel? result;

          if (myToken == 'user') {
            // المستخدم العادي يعدل السبب
            result = await Navigator.push<FurloughRequestModel>(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => FurloughRequestsBloc(),
                  child: UpdateFurloughScreen(furlough: furlough),
                ),
              ),
            );
          } else {
            // المدير يعدل الحالة
            result = await Navigator.push<FurloughRequestModel>(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => FurloughRequestsBloc(),
                  child: UpdateFurloughStatusScreen(furlough: furlough),
                ),
              ),
            );
          }

          if (result != null) {
            refreshData(result);
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

    ),
    );
  }
}
