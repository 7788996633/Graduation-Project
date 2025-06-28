import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/document_model.dart';

import '../../blocs/documents_bloc/document_bloc.dart';
import '../../blocs/documents_bloc/document_event.dart';
import '../../blocs/documents_bloc/document_state.dart';
import 'document_item.dart';

class DocumentList extends StatefulWidget {
  const DocumentList({super.key, required this.bloc});
  final DocumentBloc bloc;

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  @override
  void initState() {
    widget.bloc.add(GetAllDocumentsEvent());
    super.initState();
  }

  List<DocumentModel> documentList = [];

  Widget buildDocumentListView() {
    return ListView.builder(
      itemCount: documentList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => DocumentItem(
        document: documentList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocumentBloc, DocumentState>(
      listener: (context, state) {
        if (state is DocumentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllDocumentsEvent());
        } else if (state is DocumentFail) {
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
      child: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is DocumentListLoaded) {
            documentList = state.documentsList;
            return documentList.isEmpty
                ? const Text('There are no documents')
                : buildDocumentListView();
          } else if (state is DocumentFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errmsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
