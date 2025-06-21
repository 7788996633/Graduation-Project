part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class GetAllNotificationsEvent extends NotificationEvent {}

class MarkAllNotificationsReadEvent extends NotificationEvent {}

class MarkNotificationReadEvent extends NotificationEvent {
  final String notificationId;

  MarkNotificationReadEvent({required this.notificationId});
}

class DeleteNotificationEvent extends NotificationEvent {
  final String notificationId;

  DeleteNotificationEvent({required this.notificationId});
}
