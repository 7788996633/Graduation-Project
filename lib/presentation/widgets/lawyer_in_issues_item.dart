import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../data/models/lawyer_model.dart';
import 'info_row.dart';

class LawyerInIssuesItem extends StatelessWidget {
  final LawyerModel lawyerInIssues;
  const LawyerInIssuesItem({
    super.key,
    required this.lawyerInIssues,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => LawyerInIssuesBloc(),
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
              //  backgroundImage: NetworkImage(),
              ),
          title: Text(
            lawyerInIssues.name,
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
                value: '${lawyerInIssues.experienceYears} years',
              ),
              InfoRow(
                title: 'Specialization:',
                value: '${lawyerInIssues.specialization} ',
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => LawyerInIssuesBloc(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
