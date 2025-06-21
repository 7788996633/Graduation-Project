import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/lawyer_model.dart';
import '../../data/services/lawyer_profile_services.dart';

part 'lawyer_profile_event.dart';
part 'lawyer_profile_state.dart';

class LawyerProfileBloc extends Bloc<LawyerProfileEvent, LawyerProfileState> {
  LawyerProfileBloc() : super(LawyerProfileInitial()) {
    on<LawyerProfileEvent>(
      (event, emit) async {
        if (event is CreateLawyerProfileEvent) {
          emit(
            LawyerProfileLoading(),
          );
          try {
            String value = await LawyerProfileServices().creatLawyerProrile(
                event.licenseNumber,
                event.experienceYears,
                event.specialization,
                event.certificatePath);
            emit(
              LawyerProfileSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              LawyerProfileFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is ShowLawyerProfileEvent) {
          emit(
            LawyerProfileLoading(),
          );
          try {
            // جلب بيانات المحامي
            LawyerModel lawyer =
                await LawyerProfileServices().getMyLawyerProfile();

            // جلب بيانات المستخدم

            // دمج البيانات في الحالة
            emit(
              LawyerProfileLoadedSuccessfully(
                lawyerModel: lawyer,
              ),
            );
          } catch (e) {
            emit(LawyerProfileFail(errmsg: e.toString()));
          }
        } else if (event is UpdateLawyerProfileEvent) {
          emit(
            LawyerProfileLoading(),
          );
          try {
            String value = await LawyerProfileServices().updateLawyerProrile(
                event.licenseNumber,
                event.experienceYears,
                event.specialization,
                event.certificatePath,
                event.phone,
                event.imagePath,
                event.address,
                event.age);
            emit(
              LawyerProfileSuccess(
                successmsg: value,
              ),
            );
          } catch (e) {
            emit(
              LawyerProfileFail(
                errmsg: e.toString(),
              ),
            );
          }
        } else if (event is ShowLawyerProfileByIdEvent) {
          emit(
            LawyerProfileLoading(),
          );
          try {
            // جلب بيانات المحامي
            LawyerModel lawyer = await LawyerProfileServices()
                .getLawyerProfileById(event.lawyerId);

            // جلب بيانات المستخدم

            // دمج البيانات في الحالة
            emit(
              LawyerProfileLoadedSuccessfully(
                lawyerModel: lawyer,
              ),
            );
          } catch (e) {
            emit(
              LawyerProfileFail(
                errmsg: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
