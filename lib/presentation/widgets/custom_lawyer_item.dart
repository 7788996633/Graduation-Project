import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../data/models/lawyer_model.dart';
import '../../constant.dart';
import '../screens/lawyer_screens/lawyer_profile_screens/lawyer_details_screen.dart';
import 'info_row.dart';
import '../../../../themes.dart';

class CustomLawyerItem extends StatelessWidget {
  const CustomLawyerItem({
    super.key,
    required this.lawyer,
    this.subtitle,
    this.trailing,
    this.isSelected = false,
  });

  final LawyerModel lawyer;
  final Widget? subtitle;
  final Widget? trailing;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (myUserId == lawyer.id) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Notice'),
              content: const Text('This is your own profile.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => LawyerProfileBloc(),
                child: LawyerDetailsScreen(
                  lawyerId: lawyer.id,
                ),
              ),
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: Colors.deepPurple.withOpacity(0.3),
        color: AppColors.scaffold, // سماوي فاتح
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      '${lawyer.image}?v=${DateTime.now().millisecondsSinceEpoch}',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lawyer.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.indigo[900], // أزرق غامق مناسب
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        InfoRow(
                          title: 'Experience:',
                          value: '${lawyer.experienceYears} yrs',
                          textColor: Colors.blueGrey[700], // لون هادئ وواضح
                          fontSize: 17,
                        ),
                        const SizedBox(height: 4),
                        InfoRow(
                          title: 'Specialization:',
                          value: lawyer.specialization,
                          textColor: Colors.blueGrey[800], // نفس لون النصوص الأخرى
                          fontSize: 17,
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 8),
                    trailing!,
                  ],
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
