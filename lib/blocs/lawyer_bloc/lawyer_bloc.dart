import 'package:bloc/bloc.dart';

import '../../data/models/lawyer_model.dart';
import '../../data/repositories/lawyer_repository.dart';
import '../../data/services/users_services.dart';

import 'lawyer_event.dart';
import 'lawyer_state.dart';

class LawyerBloc extends Bloc<LawyerEvent, LawyerState> {
  LawyerBloc() : super(LawyerInitial()) {
    List<LawyerModel> allLawyers = [];
    on<LawyerEvent>(
      (event, emit) async {
        if (event is GetAllLawyersEvent) {
          emit(
            LawyerLoading(),
          );
          try {
            allLawyers = await LawyerRepository().getAllLawyers();
            emit(
              LawyersListLoaded(
                lawyersList: allLawyers,
              ),
            );
          } catch (e) {
            emit(
              LawyerFail(
                errorMsg: e.toString(),
              ),
            );
          }
        } else if (event is DeleteLawyerByIdEvent) {
          emit(
            LawyerLoading(),
          );

          try {
            String successMsg =
                await UsersServices().deleteUserById(event.lawyerId);
            emit(
              LawyerSuccess(
                successMsg: successMsg,
              ),
            );
          } catch (e) {
            emit(
              LawyerFail(
                errorMsg: e.toString(),
              ),
            );
          }
        } else if (event is SearchLawyersByNameEvent) {
          emit(LawyerLoading());

          try {
            final query = event.name.trim().toLowerCase();

            List<LawyerModel> filteredLawyers = allLawyers.where(
              (lawyer) {
                return lawyer.name.toLowerCase().contains(query);
              },
            ).toList();

            emit(
              LawyersListLoaded(
                lawyersList: filteredLawyers,
              ),
            );
          } catch (e) {
            emit(
              LawyerFail(
                errorMsg: e.toString(),
              ),
            );
          }
        } else if (event is FilterLawyers) {
          emit(
            LawyerLoading(),
          );
          try {
            final filtered = allLawyers
                .where(
                  (lawyer) => event.filter.apply(
                    lawyer,
                  ),
                )
                .toList();
            emit(
              LawyersListLoaded(
                lawyersList: filtered,
              ),
            );
          } catch (e) {
            emit(
              LawyerFail(
                errorMsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
