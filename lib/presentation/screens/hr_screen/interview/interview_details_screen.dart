import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../../data/models/interview_model.dart';
import 'update_interview_result _user.dart';
import 'update_interview_screen.dart' show UpdateInterviewScreen;

class InterviewDetailsScreen extends StatefulWidget {
  final InterviewModel interviewModel;
  final String myRole;

  const InterviewDetailsScreen({
    super.key,
    required this.interviewModel,
    required this.myRole,
  });

  @override
  State<InterviewDetailsScreen> createState() => _InterviewDetailsScreenState();
}

class _InterviewDetailsScreenState extends State<InterviewDetailsScreen> {
  late InterviewModel interview;

  @override
  void initState() {
    super.initState();
    interview = widget.interviewModel;
  }

  void refreshData(InterviewModel updated) {
    setState(() {
      interview = updated;
    });
  }

  String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE, d MMMM yyyy').format(dateTime);
  }

  String getFormattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
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
      appBar: const CustomActionAppBar(title: 'Interview Details'),
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
                  child: Icon(Icons.event_note_outlined,
                      size: 72, color: AppColors.darkBlue),
                ),
                const SizedBox(height: 20),


                _buildInfoRow(
                  icon: Icons.calendar_month,
                  label: 'Date',
                  value:
                  '${getFormattedDate(interview.date)}\n${getFormattedTime(interview.date)}',
                  valueColor: AppColors.darkBlue,
                ),

                _buildInfoRow(
                  icon: Icons.check_circle,
                  label: 'Result',
                  value: interview.result,
                ),

                _buildInfoRow(
                  icon: Icons.note,
                  label: 'Note',
                  value: interview.note ?? 'Nothing',
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push<InterviewModel>(
            context,
            MaterialPageRoute(
              builder: (_) => widget.myRole.toLowerCase() == 'hr'
                  ? UpdateInterviewScreen(interview: interview)   // خاص للـ HR
                  : UpdateInterviewResultScreen(interview: interview), // خاص لليوزر
            ),

          );

          if (result != null) {
            refreshData(result);
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
