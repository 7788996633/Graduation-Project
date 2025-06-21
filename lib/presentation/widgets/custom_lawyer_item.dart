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
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6,
        shadowColor: Colors.deepPurple.withOpacity(0.3),
        color: isSelected ? AppColors.darkBlue : Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              '${lawyer.image}?v=${DateTime.now().millisecondsSinceEpoch}',
            ),
          ),
          title: Text(
            lawyer.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isSelected ? Colors.white : const Color(0XFF472A0C),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoRow(
                title: 'Experience:',
                value: '${lawyer.experienceYears} years',
                textColor: isSelected ? Colors.white70 : null,
              ),
              InfoRow(
                title: 'Specialization:',
                value: '${lawyer.specialization} ',
                textColor: isSelected ? Colors.white70 : null,
              ),
            ],
          ),
          trailing: trailing,
        ),
      ),
    );
  }
}
