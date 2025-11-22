import 'package:bloc/bloc.dart';
import '../../data/models/complaint_model.dart';
import '../../data/repositories/complaint_repository.dart';
import '../../data/services/complaint_services.dart';
import 'complaint_event.dart';
import 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintInitial()) {
    on<ComplaintEvent>((event, emit) async {
      if (event is CreateComplaintEvent) {
        emit(ComplaintLoading());
        try {
          String result = await ComplaintServices().addComplaint(
            event.description,
          );
          emit(ComplaintSuccess(successMsg: result));
        } catch (e) {
          emit(ComplaintFail(errMsg: e.toString()));
        }
      }
      else if (event is GetAllComplaintsEvent) {
        emit(ComplaintLoading());
        try {
          List<ComplaintModel> complaintsList =
          await ComplaintRepository().getComplaints();
          emit(ComplaintListLoaded( list: complaintsList));
        } catch (e) {
          emit(ComplaintFail(errMsg: e.toString()));
        }
      }
      else if (event is GetMyComplaintsEvent) {
        emit(ComplaintLoading());
        try {
          List<ComplaintModel> complaintsList =
          await ComplaintRepository().getMyComplaints();
          emit(ComplaintListLoaded(list: complaintsList));
        } catch (e) {
          emit(ComplaintFail(errMsg: e.toString()));
        }
      }
      else if (event is GetComplaintByIdEvent) {
        emit(ComplaintLoading());
        try {
          ComplaintModel complaint =
          await ComplaintServices().getComplaintById(event.complaintId);
          emit(ComplaintLoaded(complaint: complaint));
        } catch (e) {
          emit(ComplaintFail(errMsg: e.toString()));
        }
      }
      else if (event is UpdateComplaintEvent) {
        emit(ComplaintLoading());
        try {
          String result = await ComplaintServices().updateComplaint(
            event.complaintId,
            event.description,
          );
          emit(ComplaintSuccess(successMsg: result));
        } catch (e) {
          emit(ComplaintFail(errMsg: e.toString()));
        }
      }
      else if (event is UpdateComplaintStatusEvent) {
        emit(ComplaintLoading());
        try {
          String result = await ComplaintServices().updateComplaintStatus(
            event.complaintId,
            event.status,
          );
          emit(ComplaintSuccess(successMsg: result));
        } catch (e) {
          emit(ComplaintFail(errMsg: e.toString()));
        }
      }
      else if (event is DeleteComplaintEvent) {
        emit(ComplaintLoading());
        try {
          String result =
          await ComplaintServices().deleteComplaint(event.complaintId);
          emit(ComplaintSuccess(successMsg: result));
        } catch (e) {
          emit(ComplaintFail(errMsg: e.toString()));
        }
      }
    });
  }
}
