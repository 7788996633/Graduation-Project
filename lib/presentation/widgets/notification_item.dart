import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/notification_model.dart';
import '../../../blocs/notification_bloc/notification_bloc.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<NotificationBloc>(context).add(
          MarkNotificationReadEvent(notificationId: notificationModel.id),
        );
      },
      child: Card(
        color:
            notificationModel.isRead ? Colors.white : const Color(0xFFF1F8E9),
        elevation: 2,
        child: ListTile(
          leading: Icon(
            notificationModel.isRead
                ? Icons.mark_email_read
                : Icons.mark_email_unread,
            color: notificationModel.isRead ? Colors.grey : Colors.green,
          ),
          title: Text(
            notificationModel.title,
            style: TextStyle(
              fontWeight: notificationModel.isRead
                  ? FontWeight.normal
                  : FontWeight.bold,
              color: notificationModel.isRead ? Colors.black : Colors.black87,
            ),
          ),
          subtitle: Text(notificationModel.body),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              BlocProvider.of<NotificationBloc>(context).add(
                DeleteNotificationEvent(notificationId: notificationModel.id),
              );
            },
          ),
        ),
      ),
    );
  }
}
