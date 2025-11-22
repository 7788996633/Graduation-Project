import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/required_document_bloc/required_document_bloc.dart';
import '../../../blocs/required_document_bloc/required_document_event.dart';
import '../../../constant.dart';
import '../../../data/models/required_document_model.dart';
import '../../../responsive.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/refresh_button.dart';
import '../../widgets/required_document_list.dart';
import 'add_required_documents.dart';

class ListRequiredDocumentsScreen extends StatefulWidget {
  const ListRequiredDocumentsScreen({
    super.key,
    required this.issueId,
  });
  final int issueId;
  @override
  State<ListRequiredDocumentsScreen> createState() =>
      _ListRequiredDocumentsScreenState();
}

class _ListRequiredDocumentsScreenState
    extends State<ListRequiredDocumentsScreen> {
  late RequiredDocumentsBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<RequiredDocumentsBloc>(context);
    bloc.add(GetissueRequiredDocuments(issueId: widget.issueId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RequiredDocumentList(bloc: bloc),
            if (myRole == 'admin')
              Center(
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => RequiredDocumentsBloc(),
                          child: AddRequiredDocumentScreen(
                              issueId: widget.issueId),
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
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllRequiredDocuments());
        },
      ),
    );
  }
}
