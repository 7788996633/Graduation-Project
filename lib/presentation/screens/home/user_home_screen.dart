import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/section_card.dart';
import '../settings/setting_screen.dart';
import '../../widgets/custom_home_appbar.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'Submit New Case',
        'icon': Icons.add_circle,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
      {
        'title': 'Request Legal Consultation',
        'icon': Icons.contact_support,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
      {
        'title': 'Legal Library',
        'icon': Icons.library_books,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
      {
        'title': 'Submit Complaint',
        'icon': Icons.report_problem,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
      {
        'title': 'FAQs & Legal Terms',
        'icon': Icons.question_answer,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
      {
        'title': 'Submit Training Request',
        'icon': Icons.school,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      },
    ];

    return Scaffold(
      appBar: const CustomHomeAppBar(title: 'User Panel'),
      drawer: BlocProvider(
        create: (context) => UserProfileBloc()..add(ShowUserProfileEvent()),
        child: const CustomAppDrawer(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: sections.map((section) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 24,
              child: SectionCard(
                icon: section['icon'] as IconData,
                title: section['title'] as String,
                onTap: section['onTap'] as VoidCallback,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
