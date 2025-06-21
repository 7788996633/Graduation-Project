
import 'package:bloc/bloc.dart';

import '../../data/models/document_model.dart';
import '../../data/services/document_services.dart';
import 'document_event.dart';
import 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
        DocumentBloc() : super(DocumentInitial()) {
    on<DocumentEvent>((event, emit) async {
     if (event is AddDocumentEvent) {
      emit(DocumentLoading());
      try {
      String value = await DocumentServices().addDocument(
      event.file,
      event.privacy,
      event.sessionId,
       );
        emit(DocumentSuccess(successmsg: value));
         } catch (e) {
        emit(DocumentFail(errmsg: e.toString()));}}

        else if (event is ShowDocumentByIdEvent) {
         emit(DocumentLoading());
         try {
          DocumentModel document = await DocumentServices().getDocumentById(
           event.documentId,
           event.sessionId,
          );
          emit(DocumentLoadedSuccessfully(document: document));
            } catch (e) {
                 emit(DocumentFail(errmsg: e.toString()));}}});
        }
}
