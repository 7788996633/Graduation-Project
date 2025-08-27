import 'package:meta/meta.dart';

@immutable
sealed class DashEvent {}

class FetchDashData extends DashEvent {}
