import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../data/models/delegations_model.dart';
import '../../responsive.dart';
import '../../themes.dart';
import '../screens/delegations_screen/delegation_detials_screen.dart';

class DelegationItem extends StatelessWidget {
  const DelegationItem({super.key, required this.delegation});
  final DelegationModel delegation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => LawyerInIssuesBloc(),
                ),
                BlocProvider(
                  create: (context) => DelegationBloc(),
                ),
              ],
              child: DelegationDetailsScreen(
                delegation: delegation,
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: s12, vertical: s10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(s8),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              delegation.status,
              style: TextStyle(
                  color: getCurrentTheme()['NormalText'],
                  fontSize: s16,
                  fontWeight: FontWeight.bold),
            ),
            // Text(
            //   DateFormat('d-M-yyyy').format(delegation.createdAt),
            //   style: TextStyle(
            //     color: getCurrentTheme()['NormalText'],
            //     fontSize: s14,
            //   ),
            // ),
          ],
        ),
      ),
      /* Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.deepPurple.withOpacity(0.2),
        color: Colors.deepPurple.shade50,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delete button
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () {
                      BlocProvider.of<DelegationBloc>(context).add(
                        DeleteDelegationEvent(delegationId: delegation.id),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Information section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delegation #${delegation.id}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _infoRow(Icons.confirmation_number_outlined,
                        'Session ID: ${delegation.sessionId}'),
                    _infoRow(Icons.person_outline,
                        'Original Lawyer ID: ${delegation.originalLawyerId}'),
                    // _infoRow(Icons.person_add_alt_1_outlined, 'Delegate Lawyer ID: ${delegation.delegateLawyerId}'),
                    _infoRow(
                        Icons.info_outline, 'Status: ${delegation.status}'),
                    // _infoRow(Icons.note_outlined, 'Admin Note: ${delegation.adminNote ?? '-'}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), */
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.darkBlue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14.5, color: Colors.black87, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fileRow(IconData icon, String filePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.darkBlue),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // يمكن إضافة فتح الملف أو تحميله هنا لو تحب
              },
              child: Text(
                filePath.isNotEmpty ? filePath : '-',
                style: const TextStyle(
                  fontSize: 14.5,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
