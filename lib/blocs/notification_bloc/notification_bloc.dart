import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/notification_model.dart';
import '../../data/repositories/notifications_repositories.dart';
import '../../data/services/notifications_services.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async {
      if (event is GetAllNotificationsEvent) {
        emit(
          NotificationLoading(),
        );
        try {
          List<NotificationModel> value =
              await NotificationsRepositories().getAllNotifications();
          emit(
            NotificationsListLoaded(
              notificationsList: value,
            ),
          );
        } catch (e) {
          emit(
            NotificationFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is MarkAllNotificationsReadEvent) {
        emit(
          NotificationLoading(),
        );
        try {
          String value =
              await NotificationsServices().markAllNotificationRead();
          emit(
            NotificationSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            NotificationFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is MarkNotificationReadEvent) {
        emit(
          NotificationLoading(),
        );
        try {
          String value = await NotificationsServices()
              .markNotificationRead(event.notificationId);
          emit(
            NotificationSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            NotificationFail(
              errmsg: e.toString(),
            ),
          );
        }
      } else if (event is DeleteNotificationEvent) {
        emit(
          NotificationLoading(),
        );
        try {
          String value = await NotificationsServices()
              .deleteNotification(event.notificationId);
          emit(
            NotificationSuccess(
              successmsg: value,
            ),
          );
        } catch (e) {
          emit(
            NotificationFail(
              errmsg: e.toString(),
            ),
          );
        }
      }
    });
  }
}
