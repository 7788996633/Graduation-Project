import 'package:flutter/material.dart';
import '../../../data/models/notification_model.dart'; // عدل المسار حسب مكان الـ model
import '../../../themes.dart';

import '../widgets/custom_appbar_add.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationDetailsScreen({super.key, required this.notificationModel});

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
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: const CustomActionAppBar(title: 'Notification Details'),
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
                    Icons.notifications_active_outlined,
                    size: 80,
                    color: AppColors.darkBlue,
                    shadows: [
                      Shadow(
                        color: Colors.deepPurple.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoRow('ID', notificationModel.id.toString()),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Title', notificationModel.title),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Body', notificationModel.body),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
