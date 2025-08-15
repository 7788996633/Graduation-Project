import 'package:meta/meta.dart';
import '../../data/models/legal_news_model.dart';

@immutable
sealed class LegalNewsState {}

final class LegalNewsInitial extends LegalNewsState {}

final class LegalNewsLoading extends LegalNewsState {}

final class LegalNewsSuccess extends LegalNewsState {
  final String successMsg;

  LegalNewsSuccess({required this.successMsg});
}

final class LegalNewsLoaded extends LegalNewsState {
  final LegalNewsModel news;

  LegalNewsLoaded({required this.news});
}

final class LegalNewsListLoaded extends LegalNewsState {
  final List<LegalNewsModel> list;

  LegalNewsListLoaded({required this.list});
}

final class LegalNewsFail extends LegalNewsState {
  final String errMsg;

  LegalNewsFail({required this.errMsg});
}
