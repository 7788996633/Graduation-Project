import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../data/models/lawyer_model.dart';
import '../screens/lawyer_screens/lawyer_profile_screens/lawyer_details_screen.dart';
import 'info_row.dart';

class CustomLawyerItem extends StatelessWidget {
  const CustomLawyerItem({
    super.key,
    required this.lawyer,
     this.subtitle,
     this.trailing,
  });
  final LawyerModel lawyer;
  final Widget? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        elevation: 6,
        shadowColor: Colors.deepPurple.withOpacity(0.3),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(lawyer.image),
          ),
          title: Text(
            lawyer.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0XFF472A0C),
            ),
          ),
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
          onTap: () {
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
      },

          trailing: trailing,
        ),
      ),
    );
  }
}
