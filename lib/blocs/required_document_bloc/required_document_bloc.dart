import 'package:bloc/bloc.dart';

import '../../data/models/required_document_model.dart';
import '../../data/repositories/required_document_repository.dart';
import '../../data/services/required_document_services.dart';
import 'required_document_event.dart';
import 'required_document_state.dart';

class RequiredDocumentsBloc extends Bloc<RequiredDocumentsEvent, RequiredDocumentsState> {
  RequiredDocumentsBloc() : super(RequiredDocumentsInitial()) {
    on<RequiredDocumentsEvent>((event, emit) async {
      if (event is CreateRequiredDocumentsEvent) {
        emit(RequiredDocumentsLoading());
        try {
          String value = await RequiredDocumentServices(). addRequiredDocument(event.issueId,
            event.requireFileType,
            event.note,
          );
          emit(RequiredDocumentsSuccess(successmsg: value));
        } catch (e) {
          emit(RequiredDocumentsFail(errmsg: e.toString()));
        }
      }
      if (event is GetAllRequiredDocuments) {
        emit(RequiredDocumentsLoading());
        try {
          List<RequiredDocumentModel> requiredDocumentsList =
          await RequiredDocumentRepository().getRequiredDocuments();
          emit(RequiredDocumentsListLoaded(requiredDocumentsList: requiredDocumentsList));
        } catch (e) {
          emit(RequiredDocumentsFail(errmsg: e.toString()));
        }
      } else if (event is UpdateRequiredDocumentsEvent) {
        emit(RequiredDocumentsLoading());
        try {
          String result = await RequiredDocumentServices()
              .updateRequiredDocument(event.requiredDocumentId,event.status,event.note);
          emit(RequiredDocumentsSuccess(successmsg: result));
        } catch (e) {
          emit(RequiredDocumentsFail(errmsg: e.toString()));
        }
      }else if (event is DeleteRequiredDocumentsEvent) {
        emit(RequiredDocumentsLoading());
        try {
          String result =
          await RequiredDocumentServices().deleteRequiredDocument(event.requiredDocumentId);
          emit(RequiredDocumentsSuccess(successmsg: result));
        } catch (e) {
          emit(RequiredDocumentsFail(errmsg: e.toString()));
        }
      }else if (event is UploadRequiredDocumentEvent) {
        emit(RequiredDocumentsLoading());
        try {
          String result = await RequiredDocumentServices()
              .uploadRequiredDocument(event.issueId, event.filePath);
          emit(RequiredDocumentsSuccess(successmsg: result));
        } catch (e) {
          emit(RequiredDocumentsFail(errmsg: e.toString()));
        }
      }

      else if (event is GetRequiredDocumentsById) {
        emit(RequiredDocumentsLoading());
        try {
          RequiredDocumentModel requiredDocumentId =
          await RequiredDocumentServices().getRequiredDocumentById(event.requiredDocumentId);

          emit(RequiredDocumentsLoadedSuccessfully(requiredDocumentModel: requiredDocumentId));
        } catch (e) {
          emit(RequiredDocumentsFail(errmsg: e.toString()));
        }
      }
    });
  }
}
