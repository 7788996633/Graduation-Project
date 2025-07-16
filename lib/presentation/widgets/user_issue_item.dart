import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:graduation/data/models/issues_model.dart';
import 'package:graduation/presentation/screens/admin_screens/issues_screens.dart/issuescreen.dart';
import 'package:graduation/themes.dart';

class UserIssueItem extends StatefulWidget {
  const UserIssueItem({super.key, required this.issuesModel});
  final IssuesModel issuesModel;
  @override
  State<UserIssueItem> createState() => _UserIssueItemState();
}

class _UserIssueItemState extends State<UserIssueItem> {
  late double currentPaidAmount;

  @override
  void initState() {
    currentPaidAmount = ((double.parse(widget.issuesModel.amountPaid)) /
        double.parse(widget.issuesModel.totalCost));
    print(currentPaidAmount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                          Text(
                            widget.issuesModel.status,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
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
                          Text(
                            widget.issuesModel.priority,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
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
                        widget.issuesModel.category,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'You have paid ${(currentPaidAmount * 100).toStringAsFixed(2)}% of the total cost',
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
                    width: (currentPaidAmount * 400).clamp(0.0, 400.0),
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
        ),
      ),
    );
  }
}
