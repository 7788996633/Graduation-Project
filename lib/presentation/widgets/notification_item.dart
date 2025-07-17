import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/notification_bloc/notification_bloc.dart';
import '../../../data/models/notification_model.dart';
import '../../../themes.dart';
import '../screens/notification_detials.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.shade400,
            width: 2,
          ),
        ),
        shadowColor: AppColors.darkBlue.withOpacity(0.4),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<NotificationBloc>(context),
                  child: NotificationDetailsScreen(
                    notificationModel: notificationModel,
                  ),
                ),
              ),
            );
          },
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.darkBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<NotificationBloc>(context).add(
                  DeleteNotificationEvent(notificationId: notificationModel.id),
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: AppColors.darkBlue,
                size: 28,
              ),
              tooltip: 'Delete Notification',
            ),
          ),
          title: Text(
            notificationModel.title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlue,
              letterSpacing: 0.5,
            ),
          ),
          subtitle: Text(
            notificationModel.body,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkBlue.withOpacity(0.6),
            ),
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: AppColors.darkBlue.withOpacity(0.7),
            size: 32,
          ),
        ),
      ),
    );
  }
}
