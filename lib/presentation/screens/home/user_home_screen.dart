import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import 'package:graduation/blocs/consultation_request_bloc/consultation_request_bloc.dart';
import 'package:graduation/blocs/issue_requests_bloc/issue_requests_bloc.dart';
import 'package:graduation/presentation/screens/AttendDemand/my_demands_screen.dart';
import 'package:graduation/presentation/screens/consultation_request/submit_consultation_request_screen.dart';
import 'package:graduation/presentation/screens/issue_request/add_issue_request.dart';
import 'package:graduation/presentation/screens/issue_request/user_issue_requests_screen.dart';
import 'package:graduation/presentation/screens/user_screens/user_issues_screens/user_issues_screens.dart';
import 'package:graduation/presentation/screens/user_screens/user_sessions_screen/user_session_screens.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/section_card.dart';
import '../consultation_request/all_consultation_requests_page.dart';
import '../settings/setting_screen.dart';
import '../../widgets/custom_home_appbar.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': 'All Issues',
        'icon': Icons.gavel,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssuesBloc(),
                child: const UserIssuesScreens(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Sessions',
        'icon': Icons.assignment,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionsBloc(),
                child: const UserSessionScreens(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Submit Issue Request',
        'icon': Icons.add_circle,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => IssueRequestsBloc(),
                child: const AddIssueRequestScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'My Issue Request',
        'icon': Icons.add_circle,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => IssueRequestsBloc(),
                child: const UserIssueRequestsScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Request Legal Consultation',
        'icon': Icons.contact_support,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ConsultationRequestBloc(),
                child: const SubmitConsultationRequestScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': 'Consultation Requests',
        'icon': Icons.chat_rounded,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AllConsultationRequestsPage(),
            ),
          );
        },
      },
      {
        'title': 'My Demnds',
        'icon': Icons.date_range,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (context) => AttendDemandBloc(),
                      child: const MyDemandsScreen(),
                    )),
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
