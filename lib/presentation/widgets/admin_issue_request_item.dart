import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/issue_requests_bloc/issue_requests_bloc.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/data/models/issue_request_model.dart';
import 'package:graduation/presentation/widgets/custom_text_field.dart';
import 'package:graduation/presentation/widgets/custom_user_item.dart';
import 'package:graduation/themes.dart';
import 'package:graduation/validator.dart';

import '../../blocs/issue_requests_bloc/issue_requests_event.dart';
import '../screens/issue_request/issue_request_detials_screen.dart';

class AdminIssueRequestItem extends StatefulWidget {
  const AdminIssueRequestItem({
    super.key,
    required this.request,
    required this.bloc,
  });

  final IssueRequestModel request;
  final IssueRequestsBloc bloc;

  @override
  State<AdminIssueRequestItem> createState() => _AdminIssueRequestItemState();
}

class _AdminIssueRequestItemState extends State<AdminIssueRequestItem> {
  TextEditingController noteController = TextEditingController();
  late IssueRequestStatus issueRequestStatus;
  bool isEditing = false;
  String formatDate() {
    String day = DateFormat('d').format(widget.request.createdAt);
    String month = DateFormat('m').format(widget.request.createdAt);
    String year = DateFormat('yyyy').format(widget.request.createdAt);
    return '$day/$month/$year';
  }

  @override
  void initState() {
    issueRequestStatus = stringToStatus(widget.request.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isEditing) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: widget.bloc,
                child: IssueRequestDetailsScreen(
                  userModel: widget.request.userModel,
                  issueRequest: widget.request,
                ),
              ),
            ),
          );
        }
        // (myRole == 'admin')
        //     ? widget.bloc.add(GetAllIssueRequestsEvent())
        //     : widget.bloc.add(GetMyIssueRequestsEvent());
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
          crossAxisAlignment: CrossAxisAlignment.end,
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (isEditing)
                          ? DropdownButton<IssueRequestStatus>(
                              value: issueRequestStatus,
                              items: IssueRequestStatus.values.map((value) {
                                return DropdownMenuItem<IssueRequestStatus>(
                                  value: value,
                                  child: Text(statusToString(value)),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    issueRequestStatus = newValue;
                                  });
                                }
                              },
                            )
                          : Text(
                              statusToString(issueRequestStatus),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                      Text(
                        widget.request.userModel.name,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDate(),
                      ),
                      Text(
                        widget.request.title,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              widget.request.description,
            ),
            if (isEditing &&
                statusToString(issueRequestStatus).toLowerCase() != 'pending')
              CustomTextFeild(
                controller: noteController,
                color: AppColors.darkBlue,
                text: "Add your note...",
                icon: Icons.note_add,
                validator: Validator.noteValidator,
              ),
            if (myRole == 'admin')
              Center(
                child: IconButton(
                  onPressed: () {
                    if (isEditing) {
                      if (statusToString(issueRequestStatus).toLowerCase() !=
                          widget.request.status.toLowerCase()) {
                        widget.bloc.add(
                          UpdateIssueRequestEventAsAnAdmin(
                            issueRequestId: widget.request.id,
                            status: statusToString(
                              issueRequestStatus,
                            ).toLowerCase(),
                            adminNote: noteController.text,
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
    CustomUserItem(
      userModel: widget.request.userModel,
      subtitle: Text(widget.request.title),
      trailing: myRole == "admin"
          ? PopupMenuButton(
              onSelected: (value) {
                if (value == IssueRequestStatus.approved) {
                  print("Approved");
                } else if (value == IssueRequestStatus.rejected) {
                  print("Rejected");
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: IssueRequestStatus.approved,
                  child: Text("Approve"),
                ),
                PopupMenuItem(
                  value: IssueRequestStatus.rejected,
                  child: Text("Reject"),
                ),
              ],
            )
          : const SizedBox(),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: widget.bloc,
              child: IssueRequestDetailsScreen(
                userModel: widget.request.userModel,
                issueRequest: widget.request,
              ),
            ),
          ),
        );
        (myRole == 'admin')
            ? widget.bloc.add(GetAllIssueRequestsEvent())
            : widget.bloc.add(GetMyIssueRequestsEvent());
      },
    );
  }
}
