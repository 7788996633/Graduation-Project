import 'package:flutter/material.dart';

import '../../data/models/lawyer_model.dart';
import 'custom_lawyer_item.dart';
import 'info_row.dart';

class AllLawyersListItem extends StatelessWidget {
  const AllLawyersListItem({super.key, required this.lawyer});
  final LawyerModel lawyer;

  @override
  Widget build(BuildContext context) {
    return CustomLawyerItem(
      lawyer: lawyer,
      subtitle: Column(
        children: [
          InfoRow(
            title: 'Experience:',
            value: '${lawyer.experienceYears} years',
          ),
          InfoRow(
            title: 'Specialization:',
            value: '${lawyer.specialization} ',
          ),
        ],
      ),
    );
  }
}
