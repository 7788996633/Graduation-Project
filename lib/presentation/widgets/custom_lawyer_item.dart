import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../data/models/lawyer_model.dart';
import '../../constant.dart';
import '../screens/lawyer_screens/lawyer_profile_screens/lawyer_details_screen.dart';
import 'info_row.dart';

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
                child: LawyerDetailsScreen(lawyerId: lawyer.id),
              ),
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: isSelected ? 6 : 4,
        shadowColor: Colors.deepPurple.withOpacity(0.2),
        color: isSelected ? AppColors.darkBlue : Colors.white,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            vertical: isSelected ? 10 : 8,
            horizontal: isSelected ? 10 : 10,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: isSelected ? 20 : 18,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSelected ? 13.5 : 12,
                        color: isSelected ? Colors.white : const Color(0XFF472A0C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    InfoRow(
                      title: 'Exp:',
                      value: '${lawyer.experienceYears}y',
                      textColor: isSelected ? Colors.white70 : Colors.black87,
                      fontSize: isSelected ? 12 : 11,
                    ),
                    InfoRow(
                      title: 'Spec:',
                      value: lawyer.specialization,
                      textColor: isSelected ? Colors.white70 : Colors.black87,
                      fontSize: isSelected ? 12 : 11,
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
