import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../data/models/required_document_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/required_document_list.dart';

class MyRequiredDocUp extends StatefulWidget {
  final int issueId;

  const MyRequiredDocUp({super.key, required this.issueId});

  @override
  State<MyRequiredDocUp> createState() => _MyRequiredDocUpState();
}

class _MyRequiredDocUpState extends State<MyRequiredDocUp> {
  late RequiredDocumentsBloc bloc;
  late final RequiredDocumentModel requiredDocument;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RequiredDocumentsBloc>(context);
    bloc.add(GetMyRequiredDocUp(issueId: widget.issueId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: ' My Required Doc Up',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            RequiredDocumentList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetMyRequiredDocUp(issueId: widget.issueId));
        },
      ),
    );
  }
}