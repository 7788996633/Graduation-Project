import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';

import '../../constant.dart';
import '../../data/models/issues_model.dart';
import '../../responsive.dart';
import '../../themes.dart';
import '../screens/admin_screens/issues_screens.dart/issuescreen.dart';

class UserIssueItem extends StatefulWidget {
  const UserIssueItem({
    super.key,
    required this.issuesModel,
    required this.issuesBloc,
  });

  final IssuesModel issuesModel;
  final IssuesBloc issuesBloc;

  @override
  State<UserIssueItem> createState() => _UserIssueItemState();
}

class _UserIssueItemState extends State<UserIssueItem>
    with SingleTickerProviderStateMixin {
  late double currentPaidAmount;
  bool isEditing = false;
  late IssuePriority issuePriority;
  late IssueStatus issueStatus;
  late AnimationController animationController;
  late Animation<double> animation;
  late bool isArchived;

  @override
  void initState() {
    currentPaidAmount = ((double.parse(widget.issuesModel.amountPaid)) /
        double.parse(widget.issuesModel.totalCost));
    issuePriority = stringToPriority(widget.issuesModel.priority);
    issueStatus = stringToStatus(widget.issuesModel.status);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();
    isArchived = (statusToString(issueStatus).toLowerCase() == 'archived');
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (!isEditing) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => UserProfileBloc(),
                    child: IssueScreen(
                      issuesModel: widget.issuesModel,
                    ),
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------------- معلومات المستخدم ----------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.issuesModel.user.profileModel.image,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.issuesModel.user.name,
                          style: TextStyle(
                            color: getCurrentTheme()['BoldText'],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    if (myRole == 'admin')
                    // ---------------------- زر الأرشفة ----------------------
                      IconButton(
                        onPressed: () {
                          widget.issuesBloc.add(
                            isArchived
                                ? UnArchiveIssueEvent(
                                issueId: widget.issuesModel.id)
                                : ArchiveIssueEvent(
                              issueId: widget.issuesModel.id,
                            ),
                          );
                        },
                        icon: Icon(
                          isArchived ? Icons.unarchive : Icons.archive,
                          color: isArchived
                              ? Colors.grey[700]
                              : AppColors.darkBlue,
                        ),
                        tooltip:
                        isArchived ? tr("unarchive") : tr("archive"),
                      ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                  backgroundColor: Colors.green, radius: 5),
                              const SizedBox(width: 5),
                              isEditing &&
                                  statusToString(issueStatus) != "archived"
                                  ? DropdownButton<IssueStatus>(
                                value: issueStatus,
                                items: IssueStatus.values.map((value) {
                                  return DropdownMenuItem<IssueStatus>(
                                    value: value,
                                    child: Text(
                                        statusToString(value)
                                            .toLowerCase() !=
                                            "archived"
                                            ? tr(statusToString(value))
                                            : ''),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      issueStatus = newValue;
                                    });
                                  }
                                },
                              )
                                  : Text(
                                tr(statusToString(issueStatus)),
                                style: TextStyle(
                                  color: getCurrentTheme()['BoldText'],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const CircleAvatar(
                                  backgroundColor: Colors.redAccent, radius: 5),
                              const SizedBox(width: 5),
                              isEditing
                                  ? DropdownButton<IssuePriority>(
                                value: issuePriority,
                                items: IssuePriority.values.map((value) {
                                  return DropdownMenuItem<IssuePriority>(
                                    value: value,
                                    child:
                                    Text(tr(priorityToString(value))),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      issuePriority = newValue;
                                    });
                                  }
                                },
                              )
                                  : Text(
                                tr(priorityToString(issuePriority)),
                                style: TextStyle(
                                  color: getCurrentTheme()['BoldText'],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // العنوان ورقم القضية
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.issuesModel.title,
                            style: TextStyle(
                              color: getCurrentTheme()['BoldText'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.issuesModel.issueNumber,
                            style: TextStyle(
                              color: getCurrentTheme()['BoldText'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ---------------------- شريط الدفع ----------------------
                if (myRole != 'lawyer') ...[
                  Text(
                    tr("payment_status", args: [
                      myRole == 'admin'
                          ? widget.issuesModel.user.name
                          : tr("you"),
                      (currentPaidAmount * 100).toStringAsFixed(2)
                    ]),
                    style: TextStyle(color: getCurrentTheme()['BoldText']),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: s390f,
                    child: Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey,
                          ),
                          height: 40,
                        ),
                        Positioned(
                          width: (currentPaidAmount * animation.value * s390f)
                              .clamp(0.0, s390f),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.darkBlue.withOpacity(0.5),
                            ),
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                if (myRole == 'admin' && !isArchived)
                  BlocConsumer<IssuesBloc, IssuesState>(
                    listener: (context, state) {
                      if (state is IssuesSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.greenAccent,
                            content: Text(state.successmsg),
                          ),
                        );
                      } else if (state is IssuesFail) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Text(state.errmsg),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: IconButton(
                          onPressed: () {
                            if (isEditing &&
                                statusToString(issueStatus) != "archived") {
                              if (priorityToString(issuePriority)
                                  .toLowerCase() !=
                                  widget.issuesModel.priority.toLowerCase()) {
                                widget.issuesBloc.add(
                                  UpdateIssuePriorityEvent(
                                    issueId: widget.issuesModel.id,
                                    priority: priorityToString(issuePriority)
                                        .toLowerCase(),
                                  ),
                                );
                              }
                              if (statusToString(issueStatus).toLowerCase() !=
                                  widget.issuesModel.status.toLowerCase()) {
                                widget.issuesBloc.add(
                                  UpdateIssueStatusEvent(
                                    issueId: widget.issuesModel.id,
                                    status: statusToString(issueStatus)
                                        .toLowerCase(),
                                  ),
                                );
                              }
                            }
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                          icon: Icon(
                            isEditing ? Icons.check : Icons.edit,
                            color: getCurrentTheme()['Icons'],
                          ),
                          tooltip: isEditing ? tr("confirm") : tr("edit"),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
