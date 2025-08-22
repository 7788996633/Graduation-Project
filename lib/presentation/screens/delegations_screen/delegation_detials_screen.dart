import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../../blocs/delegations_bloc/delegations_event.dart';
import '../../../blocs/delegations_bloc/delegations_state.dart';
import '../../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../../data/models/delegations_model.dart';
import '../../../data/models/lawyer_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/lawyer_radio_item.dart';
import '../../widgets/select_lawyer_for_session_list.dart';

class DelegationDetailsScreen extends StatefulWidget {
  const DelegationDetailsScreen({super.key, required this.delegation});
  final DelegationModel delegation;

  @override
  State<DelegationDetailsScreen> createState() =>
      _DelegationDetailsScreenState();
}

class _DelegationDetailsScreenState extends State<DelegationDetailsScreen> {
  late int selectedLawyerId;

  bool isAddingNote = false;
  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    selectedLawyerId = widget.delegation.originalLawyerId;

    BlocProvider.of<LawyerInIssuesBloc>(context).add(
      GetAllLawyersInIssuesEvent(
        issueId: widget.delegation.issueId,
      ),
    );
  }

  late int delegatedLawyerId;
  List<LawyerModel> lawyers = [];
  bool isSelectingLawyer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomActionAppBar(
        title: 'Delegation Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoText('ID', widget.delegation.id.toString()),
            _infoText('Status', widget.delegation.status),
            GestureDetector(
                onTap: () {
                  isAddingNote = !isAddingNote;
                  setState(() {});
                },
                child: _infoText(
                    'Admin Note', widget.delegation.adminNote ?? '-')),
            if (isAddingNote ) ...[
              CustomTextFeild(
                text: "Add outcome...",
                controller: noteController,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // BlocProvider.of<SessionsBloc>(context).add(
                    //   UpdateSessionEvent(
                    //     outcome: '',
                    //     isAttend: widget.sessionModel.isAttend,
                    //     sessionId: widget.sessionModel.issueId,
                    //   ),
                    // );
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
            _infoText('Session ID', widget.delegation.sessionId.toString()),
            _infoText('Original Lawyer ID',
                widget.delegation.originalLawyerId.toString()),
            _infoText('Delegate Lawyer ID',
                widget.delegation.delegateLawyerId.toString()),
            _infoText(
                'Delegation File', widget.delegation.delegationFile ?? '-'),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelectingLawyer
                      ? getCurrentTheme()['Border']!
                      : Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        isSelectingLawyer = !isSelectingLawyer;
                        setState(() {});
                      },
                      child: Text(
                        "Select new lawyer",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  if (isSelectingLawyer &&widget.delegation.status=='pending') ...[
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<LawyerInIssuesBloc, LawyerInIssuesState>(
                      builder: (context, state) {
                        if (state is LawyerInIssuesListLoadedSuccessfully) {
                          lawyers = state.lawyerInissues;
                          if (lawyers.isEmpty) {
                            return const Center(
                              child: Text("No lawyers found."),
                            );
                          } else {
                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: lawyers.length,
                              separatorBuilder: (_, i) => SizedBox(
                                height: 12,
                              ),
                              itemBuilder: (context, index) {
                                return LawyerRadioItem(
                                  lawyerModel: lawyers[index],
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        selectedLawyerId = value!;
                                      },
                                    );
                                    // widget.onLawyerSelected?.call(value);
                                  },
                                  groupValue: selectedLawyerId,
                                );
                              },
                            );
                          }
                        } else if (state is LawyerInIssuesFail) {
                          return Text(
                            state.errmsg,
                            style: TextStyle(
                              color: getCurrentTheme()['NormalText'],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          delegatedLawyerId = selectedLawyerId;
                          setState(() {});
                          print("delegatedLawyerId $delegatedLawyerId");
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocConsumer<DelegationBloc, DelegationState>(
              listener: (context, state) {
                if (state is DelegationSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.successMsg),
                      backgroundColor: Colors.greenAccent,
                    ),
                  );
                } else if (state is DelegationFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errMsg),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                      ),
                      onPressed: () {
                        BlocProvider.of<DelegationBloc>(context).add(
                          AddApproveDelegationEvent(
                            delegationId: widget.delegation.id,
                            adminNote: noteController.text,
                            delegateLawyerId: delegatedLawyerId,
                          ),
                        );
                      },
                      child: Text(
                        "Approve",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        BlocProvider.of<DelegationBloc>(context).add(
                          AddRejectDelegationEvent(
                            delegationId: widget.delegation.id,
                            adminNote: noteController.text,
                            originalLawyerId:
                                widget.delegation.originalLawyerId,
                            sessionId: widget.delegation.issueId,
                          ),
                        );
                      },
                      child: Text(
                        "Reject",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
            if (widget.delegation.delegationFile.isNotEmpty) ...[
              Text(
                'Attached File',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageFullScreen(
                          url: widget.delegation.delegationFile),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.delegation.delegationFile,
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      alignment: Alignment.center,
                      child: const Text(
                        'Failed to load file',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            ] else
              Text(
                'No attached file',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.deepPurple.shade700,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageFullScreen extends StatelessWidget {
  final String url;
  const ImageFullScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('View Image'),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(url),
        ),
      ),
    );
  }
}
