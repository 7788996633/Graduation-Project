part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationLoading extends NotificationState {}

final class NotificationsListLoaded extends NotificationState {
  final List<NotificationModel> notificationsList;

  NotificationsListLoaded({required this.notificationsList});
}

final class NotificationSuccess extends NotificationState {
  final String successmsg;

  NotificationSuccess({required this.successmsg});
}

final class NotificationFail extends NotificationState {
  final String errmsg;

  NotificationFail({required this.errmsg});
}

final class UnreadNotificationsListLoaded extends NotificationState {
  final List<NotificationModel> notificationsList;

  UnreadNotificationsListLoaded({required this.notificationsList});
}
