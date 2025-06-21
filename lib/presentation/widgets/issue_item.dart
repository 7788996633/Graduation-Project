import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_bloc/issues_bloc.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../data/models/issues_model.dart';
import '../screens/admin_screens/issues_screens.dart/issuescreen.dart';

class IssueItem extends StatefulWidget {
  final IssuesModel issuesModel;
  const IssueItem({super.key, required this.issuesModel});

  @override
  State<IssueItem> createState() => _IssueItemState();
}

class _IssueItemState extends State<IssueItem> {
  late IssuePriority selectedPriority;
  late IssueStatus selectedStatus;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    selectedPriority = stringToPriority(widget.issuesModel.priority);
    selectedStatus = stringToStatus(widget.issuesModel.status);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: () {
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
        },
        title: Text(widget.issuesModel.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Priority: "),
                isEditing
                    ? DropdownButton<IssuePriority>(
                        value: selectedPriority,
                        items: IssuePriority.values.map((value) {
                          return DropdownMenuItem<IssuePriority>(
                            value: value,
                            child: Text(
                              priorityToString(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedPriority = newValue;
                            });
                          }
                        },
                      )
                    : Text(priorityToString(selectedPriority)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text("Status: "),
                isEditing
                    ? DropdownButton<IssueStatus>(
                        value: selectedStatus,
                        items: IssueStatus.values.map((value) {
                          return DropdownMenuItem<IssueStatus>(
                            value: value,
                            child: Text(statusToString(value)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedStatus = newValue;
                            });
                          }
                        },
                      )
                    : Text(statusToString(selectedStatus)),
              ],
            ),
            if (isEditing)
              ElevatedButton(
                onPressed: () {},
                child: const Text("Delete"),
              ),
          ],
        ),
        trailing: BlocConsumer<IssuesBloc, IssuesState>(
          listener: (context, state) {
            if (state is IssuesSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.successmsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is IssuesFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errmsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return IconButton(
              icon: Icon(isEditing ? Icons.check : Icons.edit),
              onPressed: () {
                if (isEditing) {
                  if (priorityToString(selectedPriority).toLowerCase() !=
                      widget.issuesModel.priority.toLowerCase()) {
                    BlocProvider.of<IssuesBloc>(context).add(
                      UpdateIssuePriorityEvent(
                        issueId: widget.issuesModel.id,
                        priority:
                            priorityToString(selectedPriority).toLowerCase(),
                      ),
                    );
                  }
                  print(
                      'Saving priority: $selectedPriority, status: $selectedStatus');
                }
                setState(() {
                  isEditing = !isEditing;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
