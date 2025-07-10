import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/lawyer_in_issues_bloc/lawyer_in_issues_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';
import '../../../blocs/sessions_bloc/sessions_bloc.dart';
import '../../../blocs/sessions_bloc/sessions_state.dart';
import '../../widgets/add_lawyer_to_session_sheet.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/session_type_selector.dart';

class CreateSessionScreen extends StatefulWidget {
  const CreateSessionScreen({super.key, required this.issueId});
  final int issueId;

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  int? selectedSessionTypeId;
  String? selectedSessionTypeName;

  void _showSessionTypeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => SessionTypeBloc()..add(GetAllSessionTypesEvent()),
        child: SessionTypeSelector(
          onSelected: (id, name) {
            setState(() {
              selectedSessionTypeId = id;
              selectedSessionTypeName = name;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Add New Sessions',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<SessionsBloc, SessionsState>(
          listener: (context, state) {
            if (state is SessionsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successmsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is SessionsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errmsg}"),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create New Session",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Session Type:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _showSessionTypeSelector,
                      child: Text(
                        selectedSessionTypeName ?? "Select Session Type",
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (selectedSessionTypeId != null) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(create: (_) => LawyerInIssuesBloc()),
                                BlocProvider(create: (_) => SessionsBloc()),
                              ],
                              child: AddLawyerToSessionSheet(
                                sessionTypeId: selectedSessionTypeId!,
                                issueId: widget.issueId,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a session type first."),
                            ),
                          );
                        }
                      },
                      child: const Text("Select Lawyer"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
