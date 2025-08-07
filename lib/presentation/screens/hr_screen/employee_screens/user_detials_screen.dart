import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserModel userModel;

  const UserDetailsScreen({super.key, required this.userModel});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late UserModel user;

  @override
  void initState() {
    super.initState();
    user = widget.userModel;
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
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'User Details',
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
                    Icons.account_circle_outlined,
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
                _buildInfoRow('ID', user.id.toString()),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Name', user.name),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Type', user.roleName),
                Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                _buildInfoRow('Email', user.email),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
