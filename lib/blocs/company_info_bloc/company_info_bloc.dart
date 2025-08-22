import 'package:bloc/bloc.dart';
import '../../data/models/company_info_model.dart';
import '../../data/services/company_info_services.dart';
import 'company_info_event.dart';
import 'company_info_state.dart';

class CompanyInfoBloc extends Bloc<CompanyInfoEvent, CompanyInfoState> {
  CompanyInfoBloc() : super(CompanyInfoInitial()) {
    on<CompanyInfoEvent>((event, emit) async {
      if (event is GetCompanyEvent) {
        emit(CompanyInfoLoading());
        try {
          CompanyInfoModel company = await CompanyInfoServices().getCompany();
          emit(CompanyInfoLoaded(company: company));
        } catch (e) {
          emit(CompanyInfoFail(errorMsg: e.toString()));
        }
      }
      else if (event is UpdateCompanyEvent) {
        emit(CompanyInfoLoading());
        try {
          // استدعاء دالة التحديث مع إضافة foundationDate
          String result = await CompanyInfoServices().updateCompany(

            event.name,
            event.address,
            event.description,
            event.goals,
            event.vision,
            event.foundationDate, // حقل جديد من نوع DateTime
          );
          emit(CompanyInfoSuccess(successMsg: result));
        } catch (e) {
          emit(CompanyInfoFail(errorMsg: e.toString()));
        }
      }
    });
  }
}
