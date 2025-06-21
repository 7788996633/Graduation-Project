import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';

import '../../widgets/custom_app_drawer.dart';
import '../../widgets/section_card.dart';
import '../hr_screen/add_hiring_request_screen.dart';
import '../hr_screen/list_hiring_requests_screen.dart';
import '../../widgets/custom_home_appbar.dart';
import 'hr_home_page.dart';

class HrHomeScreen extends StatelessWidget {
  const HrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'icon': Icons.assignment_ind,
        'title': 'Add Hiring Request',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => HiringRequestsBloc(),
                child: const AddHiringRequestScreen(),
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.people,
        'title': 'Hiring Requests',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => HiringRequestsBloc(),
                child: const ListHiringRequestsScreen(),
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.person_add,
        'title': 'Add Employee Data',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEmployeeDataPage(),
            ),
          );
        },
      },
      {
        'icon': Icons.event_available,
        'title': 'Schedule Interviews',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ScheduleInterviewsPage(),
            ),
          );
        },
      },
    ];

    return Scaffold(
      appBar: const CustomHomeAppBar(title: 'Hr Panel'),
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
