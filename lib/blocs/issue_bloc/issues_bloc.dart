import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import '../../data/models/issues_model.dart';
import '../../data/repositories/issues_repository.dart';
import '../../data/services/issus_services.dart';

part 'issues_event.dart';
part 'issues_state.dart';

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc() : super(IssuesInitial()) {
    on<IssuesEvent>(
      (event, emit) async {
        if (event is IssueAdd) {
          emit(IssuesLoading());
          try {
            String value = await IssusServices().issueCreateService(
              event.title,
              event.issueNumber,
              event.category,
              event.courtName,
              event.status,
              event.priority,
              event.startDate,
              event.endDate,
              event.totalCost,
              event.numberOfPayments,
              event.opponentName,
              event.userId,
              event.amoountPaid,
              event.description,
            );
            emit(
              IssuesSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is IssueUpdate) {
          emit(IssuesLoading());
          try {
            String value = await IssusServices().issueUpdateService(
                event.id,
                event.title,
                event.issueNumber,
                event.category,
                event.courtName,
                event.status,
                event.priority,
                event.startDate,
                event.endDate,
                event.totalCost,
                event.numberOfPayments,
                event.opponentName);
            emit(
              IssuesSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is Issuedelete) {
          emit(IssuesLoading());
          try {
            String value = await IssusServices().issueDeleteService(event.id);
            emit(
              IssuesSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is IssueShowbyId) {
          emit(
            IssuesLoading(),
          );
          try {
            IssuesModel value =
                await IssusServices().issueShowService(event.id);
            emit(
              IssuesLoadedSuccessFully(issue: value),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetAllIssuesEvent) {
          emit(
            IssuesLoading(),
          );
          try {
            List<IssuesModel> value = await IssuesRepository().getAllIssues();
            emit(
              IssuesListLoadedSuccessFully(issues: value),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is AssignIsuueToLawyerEvent) {
          emit(
            IssuesLoading(),
          );
          try {
            String value = await IssusServices()
                .addLawyerToIssueService(event.issueId, event.lawyerIds);
            emit(
              IssuesSuccess(successmsg: value),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is UpdateIssuePriorityEvent) {
          emit(
            IssuesLoading(),
          );
          try {
            String value = await IssusServices()
                .issuePriorityUpdateService(event.issueId, event.priority);
            emit(
              IssuesSuccess(successmsg: value),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetAllLawyerIssuesEvent) {
          emit(
            IssuesLoading(),
          );
          try {
            List<IssuesModel> value =
                await IssuesRepository().getAllLawyerIssues();
            emit(
              IssuesListLoadedSuccessFully(issues: value),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is GetAllClientIssuesEvent) {
          emit(
            IssuesLoading(),
          );
          try {
            List<IssuesModel> value =
                await IssuesRepository().getAllClientissues();
            emit(
              IssuesListLoadedSuccessFully(issues: value),
            );
          } catch (e) {
            emit(
              IssuesFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
