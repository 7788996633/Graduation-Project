import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/required_document_model.dart';
import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../blocs/required_document_bloc/required_document_state.dart';
import '../widgets/required_document_item.dart';

class RequiredDocumentList extends StatefulWidget {
  const RequiredDocumentList({super.key, required this.bloc});
  final RequiredDocumentsBloc bloc;

  @override
  State<RequiredDocumentList> createState() => _RequiredDocumentListState();
}

class _RequiredDocumentListState extends State<RequiredDocumentList> {
  @override
  void initState() {
    widget.bloc.add(GetAllRequiredDocuments());
    super.initState();
  }

  List<RequiredDocumentModel> documentList = [];

  Widget buildDocumentListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: documentList.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => RequiredDocumentItem(
          requiredDocument: documentList[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequiredDocumentsBloc, RequiredDocumentsState>(
      listener: (context, state) {
        if (state is RequiredDocumentsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetAllRequiredDocuments());
        } else if (state is RequiredDocumentsFail) {
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
      child: BlocBuilder<RequiredDocumentsBloc, RequiredDocumentsState>(
        builder: (context, state) {
          if (state is RequiredDocumentsListLoaded) {
            documentList = state.requiredDocumentsList;
            return documentList.isEmpty
                ? const Text('There are no required documents')
                : buildDocumentListView();
          } else if (state is RequiredDocumentsFail) {
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
