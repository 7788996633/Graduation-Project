import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../blocs/payroll_bloc/payroll_bloc.dart';
import '../../../blocs/salary_adjustments_bloc/salary_adjustments_bloc.dart';
import '../../../data/models/user_model.dart';
import '../../blocs/payroll_bloc/payroll_event.dart';
import '../../constant.dart';
import '../../themes.dart';

import '../screens/hr_screen/employee_screens/user_detials_screen.dart';
import '../screens/report_screen/repoort_user.dart';
import '../screens/salary_adjustments_screen/add_salary.dart';
import '../screens/salary_adjustments_screen/all_salary_adjustments_screen.dart';



class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PayrollBloc, PayrollState>(
      listener: (context, state) {
        if (state is PayrollLoaded) {
          final payroll = state.payroll;
          showDialog(
            context: context,
            builder: (context) => Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        tr("payroll_details"),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("✔ ${tr("payroll_added")}"),
                      Text("${tr("payment")}: ${payroll.payment}"),
                      Text("${tr("allowances")}: ${payroll.allowances}"),
                      Text("${tr("deductions")}: ${payroll.deductions}"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(tr("back")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is PayrollFail) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(tr("error")),
              content: Text(state.errMsg),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(tr("back")),
                ),
              ],
            ),
          );
        }
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsScreen(userModel: widget.userModel),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // السطر الأول: الاسم + الدور فقط
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userModel.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.userModel.roleName,
                          style: TextStyle(
                            color: getCurrentTheme()['NormalText'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // السطر الثاني: جميع الأيقونات والأزرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.attach_money, color: getCurrentTheme()['Icons']),
                      tooltip: tr("add_payroll"),
                      onPressed: () {
                        if (widget.userModel.id != null) {
                          BlocProvider.of<PayrollBloc>(context).add(
                            AddPayrollEvent(userId: widget.userModel.id),
                          );
                        }
                      },
                    ),
                    if (myRole != null && myRole.toLowerCase() == 'admin')
                      IconButton(
                        icon: Icon(Icons.picture_as_pdf, color: getCurrentTheme()['Icons']),
                        tooltip: tr("user_report"),
                        onPressed: () {
                          if (widget.userModel.id != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReportUserScreen(userId: widget.userModel.id),
                              ),
                            );
                          }
                        },
                      ),
                    // ✅ شرط إخفاء أزرار التعديلات إذا كان roleName = User
                    if (widget.userModel.roleName.toUpperCase() != "USER") ...[
                      IconButton(
                        icon: Icon(Icons.edit, color: getCurrentTheme()['Icons']),
                        tooltip: tr("add_salary_adjustment"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) => SalaryAdjustmentsBloc(),
                                child: AddSalaryAdjustmentsScreen(userId: widget.userModel.id),
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.list, color: getCurrentTheme()['Icons']),
                        tooltip: tr("list_salary_adjustments"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) => SalaryAdjustmentsBloc(),
                                child: ListSalaryAdjustmentsScreen(userId: widget.userModel.id),
                              ),
                            ),
                          );
                        },
                      ),
                    ],

                    widget.userModel.id == 1
                        ? const SizedBox()
                        : PopupMenuButton<String>(
                      onSelected: (value) async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(tr("confirm_role_change")),
                            content: Text(tr("are_you_sure_change_role", args: [value])),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(tr("cancel")),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(tr("confirm")),
                              ),
                            ],
                          ),
                        );

                        if (!context.mounted) return;

                        if (confirmed == true) {
                          if (value == 'Delete') {
                            BlocProvider.of<UserBloc>(context).add(
                              DeleteUserById(userId: widget.userModel.id),
                            );
                          } else {
                            BlocProvider.of<UserBloc>(context).add(
                              ChangeUserRole(
                                userId: widget.userModel.id,
                                role: value.toLowerCase(),
                              ),
                            );
                          }
                        }
                      },
                      icon: Icon(Icons.settings, color: getCurrentTheme()['Icons']),
                      itemBuilder: (context) => getPopupItems(widget.userModel.roleName),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> getPopupItems(String currentRole) {
    final roleOptions = <String, PopupMenuItem<String>>{
      'Lawyer': PopupMenuItem<String>(
        value: 'Lawyer',
        child: Text(tr("change_role_to_lawyer"), style: const TextStyle(color: Colors.brown)),
      ),
      'Intern': PopupMenuItem<String>(
        value: 'Intern',
        child: Text(tr("change_role_to_intern"), style: const TextStyle(color: Colors.orange)),
      ),
      'HR': PopupMenuItem<String>(
        value: 'HR',
        child: Text(tr("change_role_to_hr"), style: const TextStyle(color: Colors.yellowAccent)),
      ),
      'Accountant': PopupMenuItem<String>(
        value: 'Accountant',
        child: Text(tr("change_role_to_accountant"), style: const TextStyle(color: Colors.green)),
      ),
      'User': PopupMenuItem<String>(
        value: 'User',
        child: Text(tr("change_role_to_user"), style: const TextStyle(color: Colors.blueGrey)),
      ),
      'Admin': PopupMenuItem<String>(
        value: 'Admin',
        child: Text(tr("you_are_admin"), style: const TextStyle(color: Color.fromARGB(255, 179, 34, 106))),
      ),
      'Delete': PopupMenuItem<String>(
        value: 'Delete',
        child: Text(tr("delete_this_user"), style: const TextStyle(color: Color.fromARGB(255, 179, 34, 106))),
      ),
    };

    final current = currentRole.toUpperCase();
    if (current == 'ADMIN') return [roleOptions['Admin']!];

    final allowedTransitions = <String, List<String>>{
      'LAWYER': ['User'],
      'INTERN': ['Lawyer', 'User'],
      'HR': ['User'],
      'ACCOUNTANT': ['User'],
      'USER': ['Lawyer', 'Intern', 'HR', 'Accountant'],
    };

    final allowed = allowedTransitions[current];
    if (allowed == null) return [];
    return allowed.map((r) => roleOptions[r]!).toList();
  }
}
