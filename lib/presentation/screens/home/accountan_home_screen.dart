import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import '../../../blocs/payroll_bloc/payroll_bloc.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../widgets/section_card.dart';
 import '../all_users_list.dart';
import '../pyroll_screen/all_payroll_screen.dart';
import '../settings/setting_screen.dart';
import '../../widgets/custom_home_appbar.dart';

class AccountanHomeScreen extends StatelessWidget {
  const AccountanHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [

      {
        'title': ' list Payroll',
        'icon': Icons.report,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  BlocProvider(
                    create: (context) => PayrollBloc(),
                    child: const ListPayrollsScreen(),
                  ),
            ),
          );
        },
      },
    {
    'title': ' add Payroll',
    'icon': Icons.report,
    'onTap': () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (_) => BlocProvider(
    create: (context) => UserBloc(),
    child:ListUsersScreen(),
    ),
    ),
    );
    },
      },
      {
        'title': 'Verify Salary Delivery',
        'icon': Icons.verified_user,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SettingsScreen(),
            ),
          );
        },
      },
      {
        'title': 'Salary Delivery Schedule',
        'icon': Icons.schedule,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const SettingsScreen(),
            ),
          );
        },
      },
    ];

    return Scaffold(
      appBar: const CustomHomeAppBar(title: 'Accountant Panel'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: sections.map((section) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 24,
              child: SectionCard (
                title: section['title'] as String,
                icon: section['icon'] as IconData,
                onTap: section['onTap'] as VoidCallback,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
