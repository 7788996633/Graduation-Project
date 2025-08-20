import 'package:meta/meta.dart';

@immutable
sealed class CaseTypeEvent {}

class FetchCaseTypePercentages extends CaseTypeEvent {}
