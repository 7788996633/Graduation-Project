import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../constant.dart';
import '../../data/models/issues_model.dart';
import '../../themes.dart';
import '../screens/admin_screens/issues_screens.dart/issuescreen.dart';

class UserIssueItem extends StatefulWidget {
  const UserIssueItem(
      {super.key, required this.issuesModel, required this.issuesBloc});
  final IssuesModel issuesModel;
  final IssuesBloc issuesBloc;
  @override
  State<UserIssueItem> createState() => _UserIssueItemState();
}

class _UserIssueItemState extends State<UserIssueItem>
    with TickerProviderStateMixin {
  late double currentPaidAmount;
  bool isEditing = false;
  late IssuePriority issuePriority;
  late IssueStatus issueStatus;
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    currentPaidAmount = ((double.parse(widget.issuesModel.amountPaid)) /
        double.parse(widget.issuesModel.totalCost));
    issuePriority = stringToPriority(widget.issuesModel.priority);
    issueStatus = stringToStatus(widget.issuesModel.status);
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.forward();
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
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.issuesModel.user.profileModel.image,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.issuesModel.user.name,
                      ),
                      Spacer(),
                      Text(''),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              (isEditing)
                                  ? DropdownButton<IssueStatus>(
                                      value: issueStatus,
                                      items: IssueStatus.values.map((value) {
                                        return DropdownMenuItem<IssueStatus>(
                                          value: value,
                                          child: Text(statusToString(value)),
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
                                      statusToString(issueStatus),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                radius: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              (isEditing)
                                  ? DropdownButton<IssuePriority>(
                                      value: issuePriority,
                                      items: IssuePriority.values.map((value) {
                                        return DropdownMenuItem<IssuePriority>(
                                          value: value,
                                          child: Text(priorityToString(value)),
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
                                      priorityToString(issuePriority),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.issuesModel.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            widget.issuesModel.issueNumber,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (myRole != 'lawyer') ...[
                  Text(
                    '${myRole == 'admin' ? widget.issuesModel.user.name : "You"} have paid ${(currentPaidAmount * 100).toStringAsFixed(2)}% of the total cost',
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    width: 400,
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
                          width: (currentPaidAmount * animation.value * 400)
                              .clamp(0.0, 400.0),
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
                if (myRole == 'admin')
                  Center(
                    child: IconButton(
                      onPressed: () {
                        if (isEditing) {
                          if (priorityToString(issuePriority).toLowerCase() !=
                              widget.issuesModel.priority.toLowerCase()) {
                            widget.issuesBloc.add(
                              UpdateIssuePriorityEvent(
                                issueId: widget.issuesModel.id,
                                priority: priorityToString(
                                  issuePriority,
                                ).toLowerCase(),
                              ),
                            );
                          }
                          if (statusToString(issueStatus).toLowerCase() !=
                              widget.issuesModel.status.toLowerCase()) {
                            widget.issuesBloc.add(
                              UpdateIssueStatusEvent(
                                issueId: widget.issuesModel.id,
                                status: statusToString(
                                  issueStatus,
                                ).toLowerCase(),
                              ),
                            );
                          }
                        }
                        isEditing = !isEditing;
                        setState(() {});
                      },
                      icon: Icon(
                        isEditing ? Icons.check : Icons.edit,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
