import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../data/models/session_type_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import 'update_session_type.dart';

class SessionTypeDetailsScreen extends StatefulWidget {
  final SessionTypeModel sessionTypeModel;

  const SessionTypeDetailsScreen({super.key, required this.sessionTypeModel});

  @override
  State<SessionTypeDetailsScreen> createState() => _SessionTypeDetailsScreenState();
}

class _SessionTypeDetailsScreenState extends State<SessionTypeDetailsScreen> {
  late SessionTypeModel sessionType;

  @override
  void initState() {
    super.initState();
    sessionType = widget.sessionTypeModel;
  }

  void refreshData(SessionTypeModel updated) {
    setState(() {
      sessionType = updated;
    });
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
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
      appBar: const CustomActionAppBar(title: 'Session Type Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          color: Colors.white,
          shadowColor: Colors.deepPurple.shade100,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.event_note_outlined,
                    size: 72,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoRow(
                  icon: Icons.category_outlined,
                  label: 'Type',
                  value: sessionType.type,
                ),
                _buildInfoRow(
                  icon: Icons.stars_outlined,
                  label: 'Points',
                  value: sessionType.points.toString(),
                  valueColor: AppColors.darkBlue,
                ),
                _buildInfoRow(
                  icon: Icons.description_outlined,
                  label: 'Description',
                  value: sessionType.description,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final updatedSessionType = await Navigator.push<SessionTypeModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionTypeBloc(),
                child: UpdateSessionTypeScreen(sessionType: sessionType),
              ),
            ),
          );

          if (updatedSessionType != null) {
            refreshData(updatedSessionType);
          }
        },
        icon: const Icon(Icons.edit, color: Colors.white),
        label: const Text(
          'Edit',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.darkBlue,
      ),
    );
  }
}
