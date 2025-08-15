import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../blocs/employee_bloc/employee_bloc.dart';
import '../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';

import '../../../themes.dart';
import '../../widgets/custom_app_drawer.dart';
import '../../widgets/section_card.dart';

import '../hr_screen/employee_screens/list_employee_screen.dart';
import '../hr_screen/employee_screens/list_user_screen.dart';
import '../hr_screen/hiring_request/list_hiring_requests_screen.dart';
import '../hr_screen/hiring_request/list_lawyer_screen.dart';

import '../../widgets/custom_home_appbar.dart';

import '../report_screen/report_financial_screen.dart';
import '../report_screen/report_hiring_screen.dart';
import '../report_screen/report_invoices_screen.dart';

class HrHomeScreen extends StatefulWidget {
  const HrHomeScreen({super.key});

  @override
  State<HrHomeScreen> createState() => _HrHomeScreenState();
}

class _HrHomeScreenState extends State<HrHomeScreen> {
  // دالة لإعادة بناء الشاشة عند تغيير اللغة من صفحة الإعدادات
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'icon': Icons.assignment_ind,
        'title': tr('hiring_requests'),
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
        'icon': Icons.attach_money,
        'title': tr('set_salary_to_lawyer'),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LawyerBloc(),
                child: const ListLawyersScreen(),
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.insert_drive_file,
        'title': tr('financial_report'),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ReportFinancialScreen(),
            ),
          );
        },
      },
      {
        'icon': Icons.group,
        'title': tr('hiring_report'),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ReportHiringScreen(),
            ),
          );
        },
      },
      {
        'icon': Icons.receipt_long,
        'title': tr('invoices_report'),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ReportInvoicesScreen(),
            ),
          );
        },
      },
      {
        'icon': Icons.event_available,
        'title': tr('add_employee'),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => UserBloc(),
                child: const ListUsersScreen(),
              ),
            ),
          );
        },
      },
      {
        'icon': Icons.event_available,
        'title': tr('employees'),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => EmployeeBloc(),
                child: const ListEmployeesScreen(),
              ),
            ),
          );
        },
      },
    ];

    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomHomeAppBar(title: tr('hr_panel')),
      drawer: BlocProvider(
        create: (context) => UserProfileBloc()..add(ShowUserProfileEvent()),
        child: CustomAppDrawer(
          onSettingsClosed: refresh,
        ),
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
