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
     String result = await DocumentServices().addDocument(
      event.file,
      event.privacy,
      event.sessionId,
      event.fileName,
     );
     emit(DocumentSuccess(successmsg: result));
    } catch (e) {
     emit(DocumentFail(errmsg: e.toString()));
    }
   }

   else if (event is ShowDocumentByIdEvent) {
    emit(DocumentLoading());
    try {
     DocumentModel document = await DocumentServices().getDocumentById(
      event.documentId,
      event.sessionId,
     );
     emit(DocumentLoadedSuccessfully(document: document));
    } catch (e) {
     emit(DocumentFail(errmsg: e.toString()));
    }
   }

   else if (event is UpdateDocumentEvent) {
    emit(DocumentLoading());
    try {
     String result = await DocumentServices().updateDocument(
      documentId: event.documentId,
      file: event.file,
      fileName: event.fileName!,
      privacy: event.privacy!,
     );
     emit(DocumentSuccess(successmsg: result));
    } catch (e) {
     emit(DocumentFail(errmsg: e.toString()));
    }
   }

   else if (event is DeleteDocumentEvent) {
    emit(DocumentLoading());
    try {
     String result = await DocumentServices().deleteDocument(event.documentId);
     emit(DocumentSuccess(successmsg: result));
    } catch (e) {
     emit(DocumentFail(errmsg: e.toString()));
    }
   }
   else if (event is GetDocumentsSessionEvent) {
    emit(DocumentLoading());
    try {

     List<DocumentModel> docs = await DocumentServices().getDocumentsSession(event.sessionId,event.documentId);
     emit(DocumentListLoaded(documentsList: docs, ));
    } catch (e) {
     emit(DocumentFail(errmsg: e.toString()));
    }
   }
   else if (event is GetAllDocumentsEvent) {
    emit(DocumentLoading());
    try {
     // ملاحظة: تحتاج تنفّذها بالخدمة لو عندك getAllDocuments()
     List<DocumentModel> docs = await DocumentServices().getAllDocuments();
     emit(DocumentListLoaded(documentsList: docs, ));
    } catch (e) {
     emit(DocumentFail(errmsg: e.toString()));
    }
   }
  });
 }
}
