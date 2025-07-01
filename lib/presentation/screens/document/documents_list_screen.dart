import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../blocs/documents_bloc/document_bloc.dart';
import '../../../blocs/documents_bloc/document_event.dart';
import '../../../constant.dart';
import '../../../data/models/document_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/document_list.dart';
import '../../widgets/refresh_button.dart';

import 'add_document_screen.dart';

class ListDocumentsScreen extends StatefulWidget {
  const ListDocumentsScreen({super.key});

  @override
  State<ListDocumentsScreen> createState() => _ListDocumentsScreenState();
}

class _ListDocumentsScreenState extends State<ListDocumentsScreen> {
  late DocumentBloc bloc;
  late final DocumentModel document;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DocumentBloc>(context);
    bloc.add(GetAllDocumentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Documents',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            DocumentList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllDocumentsEvent());
        },
      ),
    );
  }
}
