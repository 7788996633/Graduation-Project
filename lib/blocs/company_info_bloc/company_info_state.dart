import 'package:meta/meta.dart';
import '../../data/models/company_info_model.dart';

@immutable
sealed class CompanyInfoState {}

final class CompanyInfoInitial extends CompanyInfoState {}

final class CompanyInfoLoading extends CompanyInfoState {}

final class CompanyInfoSuccess extends CompanyInfoState {
  final String successMsg;

  CompanyInfoSuccess({required this.successMsg});
}

final class CompanyInfoLoaded extends CompanyInfoState {
  final CompanyInfoModel company;

  CompanyInfoLoaded({required this.company});
}

final class CompanyInfoListLoaded extends CompanyInfoState {
  final List<CompanyInfoModel> companies;

  CompanyInfoListLoaded({required this.companies});
}

final class CompanyInfoFail extends CompanyInfoState {
  final String errorMsg;

  CompanyInfoFail({required this.errorMsg});
}
