import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../blocs/consultations_bloc/consultation_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';

import '../../widgets/custom_lawyer_drawer.dart';
import '../../widgets/section_card.dart';
import '../../widgets/custom_home_appbar.dart';

import '../consultation/consultations_list_screen.dart';
import '../consultation/my_consultations_lawyer_list_screen.dart';
import '../consultation_request/all_consultation_requests_page.dart';
import '../furloughs/add_furlough_screen.dart';
import '../furloughs/my_list_furloughs_screen.dart';
import '../lawyer_screens/lawyer_issues_screens/lawyer_issues_list_screen.dart';
import '../lawyer_screens/lawyer_sessions_screen.dart/lawyer_sessions_screen.dart';

class LawyerHomeScreen extends StatelessWidget {
  const LawyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': tr('all_issues'),
        'icon': Icons.gavel,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => IssuesBloc(),
                child: const LawyerIssuesListScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': tr('add_furlough'),
        'icon': Icons.beach_access,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => FurloughRequestsBloc(),
                child: const AddFurloughScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': tr('my_furloughs'),
        'icon': Icons.event_available,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => FurloughRequestsBloc(),
                child: const MyListFurloughRequestsScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': tr('sessions'),
        'icon': Icons.assignment,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionsBloc(),
                child: const LawyerSessionsScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': tr('consultations'),
        'icon': Icons.chat,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ConsultationBloc(),
                child: const ConsultationsListScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': tr('my_consultations'),
        'icon': Icons.message,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ConsultationBloc(),
                child: const MyConsultationsLawyerListScreen(),
              ),
            ),
          );
        },
      },
      {
        'title': tr('all_consultation_requests'),
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
    ];

    return Scaffold(
      appBar: CustomHomeAppBar(title: tr('lawyer_panel')),
      drawer: BlocProvider(
        create: (context) => LawyerProfileBloc()..add(ShowLawyerProfileEvent()),
        child: const CustomDrawerLawyer(),
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
