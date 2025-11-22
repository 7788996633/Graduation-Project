import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../blocs/issue_progress_reports/issue_progress_reports_bloc.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_event.dart';
import '../../../blocs/issue_progress_reports/issue_progress_reports_state.dart';
import '../../../data/models/issue_progress_reports_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateIssueProgressScreen extends StatefulWidget {
  final IssueProgressReportModel issueProgress;

  const UpdateIssueProgressScreen({super.key, required this.issueProgress});

  @override
  State<UpdateIssueProgressScreen> createState() => _UpdateIssueProgressScreenState();
}

class _UpdateIssueProgressScreenState extends State<UpdateIssueProgressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _reportController;

  bool _isSaving = false;
  bool _hasRequestedFetch = false;

  @override
  void initState() {
    super.initState();
    _reportController = TextEditingController(text: widget.issueProgress.report);
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      final updatedReport = _reportController.text.trim();

      setState(() {
        _isSaving = true;
        _hasRequestedFetch = false;
      });

      BlocProvider.of<IssueProgressReportBloc>(context).add(
        UpdateIssueProgressReportEvent(
          reportId: widget.issueProgress.id,
          report: updatedReport,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(title: 'Update Issue Progress'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<IssueProgressReportBloc, IssueProgressReportState>(
          listener: (context, state) {
            if (state is IssueProgressReportSuccess && !_hasRequestedFetch) {
              _hasRequestedFetch = true;
              BlocProvider.of<IssueProgressReportBloc>(context).add(
                GetIssueProgressReportByIdEvent(reportId: widget.issueProgress.id),
              );
            } else if (state is IssueProgressReportLoaded) {
              setState(() {
                _isSaving = false;
              });
              Navigator.pop(context, state.report);
            } else if (state is IssueProgressReportFail) {
              setState(() {
                _isSaving = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMsg),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _reportController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Report',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the report';
                      }
                      return null;
                    },
                    enabled: !_isSaving,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _submitUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                      ),
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
