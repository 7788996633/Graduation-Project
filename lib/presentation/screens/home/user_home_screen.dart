import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import '../../../blocs/legal_books_bloc/legal_books_bloc.dart';
import '../../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/section_card.dart';
import '../AttendDemand/my_demands_screen.dart';
import '../common_consulation/list_common_consul.dart';
import '../complaint_screen/add_complaint_screen.dart';
import '../complaint_screen/my_list_complaints_screen.dart';
import '../consultation_request/all_consultation_requests_page.dart';
import '../consultation_request/submit_consultation_request_screen.dart';
import '../hr_screen/hiring_request/hiring_requests_published_screen.dart';
import '../issue_request/add_issue_request.dart';
import '../issue_request/user_issue_requests_screen.dart';
import '../legal_books_screen/logal_book_list.dart';
import '../legal_news_screen/list_legal_news_screen.dart';
import '../settings/setting_screen.dart';
import '../../widgets/custom_home_appbar.dart';
import '../user_screens/user_issues_screens/user_issues_screens.dart';
import '../user_screens/user_sessions_screen/user_session_screens.dart';

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
        'title': 'common Consultations',
        'icon': Icons.question_answer_rounded,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => CommonConsultationBloc(),
                child: const ListCommonConsultationsScreen(),
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
        'icon': Icons.campaign,
        'title': tr('hiring_requests_publish'),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => HiringRequestsBloc(),
                child: const ListHiringRequestsPublishScreen(),
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
        'title': 'Complaints',
        'icon': Icons.report_problem_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ComplaintBloc(),
                child: const AddComplaintScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': ' my Complaints',
        'icon': Icons.report_problem_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ComplaintBloc(),
                child: const MyListComplaintsScreen(),
              ),
            ),
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
      {
        'title': 'Book',
        'icon': Icons.group,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => LegalBookBloc(),
                child: const ListLegalBooksScreen(),
              ),
            ),
          );
        },
      },
    {
    'title': ' add complaint',
    'icon': Icons.report,
    'onTap': () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => BlocProvider(
    create: (context) => ComplaintBloc(),
    child: const AddComplaintScreen(),
    ),
    ),
    );
    },},
      {
        'title': 'News',
        'icon':  Icons.newspaper,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => LegalNewsBloc(),
                child: const ListLegalNewsScreen(),
              ),
            ),
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
