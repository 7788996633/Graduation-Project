import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../constant.dart';
import '../../../data/models/required_document_model.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/required_document_list.dart';
import 'add_required_documents.dart';

class ListRequiredDocumentsScreen extends StatefulWidget {
  const ListRequiredDocumentsScreen({super.key,});

  @override
  State<ListRequiredDocumentsScreen> createState() => _ListRequiredDocumentsScreenState();
}

class _ListRequiredDocumentsScreenState extends State<ListRequiredDocumentsScreen> {
  late RequiredDocumentsBloc bloc;
  late final RequiredDocumentModel requiredDocument;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RequiredDocumentsBloc>(context);
    bloc.add(GetAllRequiredDocuments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Required Documents',
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
          bloc.add(GetAllRequiredDocuments());
        },
      ),
    );
  }
}
