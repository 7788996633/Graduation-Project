import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/notification_bloc/notification_bloc.dart';
import '../../../data/models/notification_model.dart';
import '../../../presentation/widgets/notification_item.dart';

class NotificationsList extends StatefulWidget {
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  @override
  void initState() {
    BlocProvider.of<NotificationBloc>(context).add(
      GetAllNotificationsEvent(),
    );
    super.initState();
  }

  List<NotificationModel> notificationsList = [];
  Widget buildNotificationModel() {
    return ListView.builder(
      itemCount: notificationsList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => NotificationItem(
        notificationModel: notificationsList[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          BlocProvider.of<NotificationBloc>(context).add(
            GetAllNotificationsEvent(),
          );
        } else if (state is NotificationFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is NotificationLoading) {
          const CircularProgressIndicator();
        }
      },
      child: Column(
        children: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationsListLoaded) {
                notificationsList = state.notificationsList;
                return notificationsList.isEmpty
                    ? const Text('There is no notifications')
                    : buildNotificationModel();
              } else if (state is NotificationFail) {
                return Column(
                  children: [
                    const Text(
                      "There is an error:",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.errmsg,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          MaterialButton(
            color: Colors.grey,
            onPressed: () {
              BlocProvider.of<NotificationBloc>(context).add(
                MarkAllNotificationsReadEvent(),
              );
            },
            child: const Text("Mark All As Read"),
          ),
        ],
      ),
    );
  }
}
