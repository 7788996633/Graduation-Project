import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/required_document_bloc/required_document_bloc.dart';
import 'package:graduation/blocs/required_document_bloc/required_document_state.dart';
import 'package:graduation/constant.dart';
import 'package:graduation/data/models/required_document_model.dart';
import 'package:graduation/presentation/screens/required_documents/add_required_documents.dart';
import 'package:graduation/responsive.dart';

import '../../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../../blocs/session_points_bloc/session_points_bloc.dart';
import '../../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../../data/models/issues_model.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../../themes.dart';
import '../../../widgets/lawyers_in_issue_list.dart';
import '../../AttendDemand/all_attend_demand_screen.dart';
import '../../invoice_screen/invoice_by_issue_id_screen.dart';
import '../../required_documents/list_required_document_screen.dart';
import '../../session/list_session_screen.dart';
import '../../session/session_points_chart.dart';

class IssueScreen extends StatefulWidget {
  final IssuesModel issuesModel;
  const IssueScreen({super.key, required this.issuesModel});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  static const Color kPrimaryDarkBlue = Color(0xFF472A0C);
  String date = '';
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(
      ShowUserProfileByIdEvent(userId: widget.issuesModel.user.id),
    );
    // BlocProvider.of<RequiredDocumentsBloc>(context).add(
    //   GetissueRequiredDocuments(
    //     issueId: widget.issuesModel.id,
    //   ),
    // );
    print("docs ${widget.issuesModel.id}");

    date = DateFormat('d/M/yy')
        .format(DateTime.parse(widget.issuesModel.startDate));
    setState(() {});
  }

  var consultationstatus = 'pending';

  Widget buildProfileCard(UserProfileModel user) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: s10,
          colors: isLight.value
              ? [AppColors.darkBlue, AppColors.softGray, AppColors.white]
              : [Colors.black, AppColors.softGray, AppColors.white],
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.image),
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF5F7FA), Color(0xFFDCE4EC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: kPrimaryDarkBlue),
        title: Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black54)),
        subtitle: Text(value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kPrimaryDarkBlue)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(milliseconds: 500),
      length: 6,
      child: Scaffold(
        backgroundColor: getCurrentTheme()['BackGorund'],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor:
              kIsWeb ? Colors.transparent : getCurrentTheme()['AppBar'],
          title: Text(
            "Case Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: s24,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: s25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.note,
                  color: Colors.white,
                  size: s25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.date_range,
                  color: Colors.white,
                  size: s25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                  size: s25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.analytics_rounded,
                  color: Colors.white,
                  size: s25,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.file_copy_rounded,
                  color: Colors.white,
                  size: s25,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            caseDetails(context),
            BlocProvider(
              create: (context) => SessionsBloc(),
              child: ListSessionsScreen(
                issueId: widget.issuesModel.id,
              ),
            ),
            AllAttendDemandScreen(
              issueId: widget.issuesModel.id,
            ),
            BlocProvider(
              create: (context) => InvoiceBloc(),
              child: ListInvoicesByIssueScreen(
                issueId: widget.issuesModel.id,
                userId: widget.issuesModel.user.id,
              ),
            ),
            SizedBox(
              height: 350,
              child: BlocProvider(
                create: (context) => SessionPointsBloc(),
                child: SessionPointsChart(
                  issueId: widget.issuesModel.id,
                ),
              ),
            ),
            BlocProvider(
              create: (context) => RequiredDocumentsBloc(),
              child: ListRequiredDocumentsScreen(
                issueId: widget.issuesModel.id,
              ),
            ),
            /*  Container(
              padding: EdgeInsets.all(
                s12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "The required documents in this case:",
                      style: TextStyle(
                          color: getCurrentTheme()['NormalText'],
                          fontSize: s20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: s10,
                  ),
                  BlocBuilder<RequiredDocumentsBloc, RequiredDocumentsState>(
                    builder: (context, state) {
                      if (state is RequiredDocumentsListLoaded) {
                        List<RequiredDocumentModel> docs =
                            state.requiredDocumentsList;
                        print("docs ${state.requiredDocumentsList}");
                        return docs.isEmpty
                            ? Text("There is no documents yet")
                            : ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => Container(
                                      padding: EdgeInsets.all(s15),
                                      decoration: BoxDecoration(
                                        gradient: RadialGradient(
                                          center: Alignment.center,
                                          radius: s10,
                                          colors: isLight
                                              ? [
                                                  AppColors.darkBlue,
                                                  AppColors.softGray,
                                                  AppColors.white,
                                                ]
                                              : [
                                                  Colors.black,
                                                  AppColors.softGray,
                                                  AppColors.white,
                                                ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(s10),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .only(end: s8),
                                                    child: Icon(
                                                      Icons.file_copy_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    docs[index].requireFileType,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: s16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    docs[index].status,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: s16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsetsDirectional
                                                            .only(start: s8),
                                                    child: Icon(
                                                      docs[index]
                                                                  .status
                                                                  .toLowerCase() ==
                                                              'approved'
                                                          ? Icons.check_circle
                                                          : consultationstatus
                                                                      .toLowerCase() ==
                                                                  'pending'
                                                              ? Icons
                                                                  .hourglass_empty
                                                              : Icons.cancel,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: s10,
                                    ),
                                itemCount: docs.length);
                      } else if (state is RequiredDocumentsFail) {
                        return Text(state.errmsg);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  if (myRole == 'admin')
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => RequiredDocumentsBloc(),
                                child: AddRequiredDocumentScreen(
                                    issueId: widget.issuesModel.id),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Add required document",
                          style: TextStyle(
                              fontSize: s16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ), */
          ],
        ),
      ),
    );
  }

  Widget caseDetails(BuildContext context) {
    return Container(
      color: getCurrentTheme()['BackGorund'],
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 100, top: 10, right: s10, left: s10),
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoadedSuccessfully) {
              final user = state.userProfileModel;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Case owner:",
                    style: TextStyle(
                      color: getCurrentTheme()['NormalText'],
                      fontSize: s20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  buildProfileCard(user),
                  const SizedBox(height: 10),
                  Text(
                    "Case Lawyers:",
                    style: TextStyle(
                      color: getCurrentTheme()['NormalText'],
                      fontSize: s20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BlocProvider(
                    create: (context) => LawyerInIssuesBloc(),
                    child: LawyersInIssueList(
                      issueId: widget.issuesModel.id,
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    "Case Datails:",
                    style: TextStyle(
                      color: getCurrentTheme()['NormalText'],
                      fontSize: s20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.all(s10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: s10,
                        colors: isLight.value
                            ? [
                                AppColors.darkBlue,
                                AppColors.softGray,
                                AppColors.white
                              ]
                            : [
                                Colors.black,
                                AppColors.softGray,
                                AppColors.white
                              ],
                      ),
                    ),
                    child: Column(
                      children: [
                        cutomRow(widget.issuesModel.title, Icons.title,
                            widget.issuesModel.issueNumber, Icons.numbers),
                        const SizedBox(height: 10),
                        Divider(),
                        cutomRow(
                            widget.issuesModel.numberOfPayments.toString(),
                            Icons.payments,
                            widget.issuesModel.totalCost,
                            Icons.attach_money),
                        const SizedBox(height: 10),
                        Divider(),
                        cutomRow(widget.issuesModel.courtName, Icons.title,
                            date, Icons.date_range),
                        const SizedBox(height: 10),
                        Divider(),
                        cutomRow(widget.issuesModel.status, Icons.help_outline,
                            widget.issuesModel.priority, Icons.flag),
                      ],
                    ),
                  ), // بقية تفاصيل القضية
                ],
              );
            } else if (state is UserProfileFail) {
              return Center(child: Text(state.errmsg));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget cutomRow(
    String text1,
    IconData icon1,
    String text2,
    IconData icon2,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: s185f,
          child: Row(
            children: [
              Icon(
                icon1,
                color: Colors.white,
              ),
              SizedBox(
                width: s5,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  text1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: s18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              text2,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: s18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: s5,
            ),
            Icon(
              icon2,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
