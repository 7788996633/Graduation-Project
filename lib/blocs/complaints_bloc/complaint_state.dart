import 'package:meta/meta.dart';
import '../../data/models/complaint_model.dart';

@immutable
sealed class ComplaintState {}

final class ComplaintInitial extends ComplaintState {}

final class ComplaintLoading extends ComplaintState {}

final class ComplaintSuccess extends ComplaintState {
  final String successMsg;

  ComplaintSuccess({required this.successMsg});
}

final class ComplaintLoaded extends ComplaintState {
  final ComplaintModel complaint;

  ComplaintLoaded({required this.complaint});
}

final class ComplaintListLoaded extends ComplaintState {
  final List<ComplaintModel> list;

  ComplaintListLoaded({required this.list});
}

final class ComplaintFail extends ComplaintState {
  final String errMsg;

  ComplaintFail({required this.errMsg});
}
