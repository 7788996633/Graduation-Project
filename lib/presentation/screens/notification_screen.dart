import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/notification_bloc/notification_bloc.dart';

import '../../../themes.dart';

import '../widgets/custom_appbar_add.dart';
import '../widgets/notifications_list.dart';
import '../widgets/refresh_button.dart';

class ListNotificationsScreen extends StatefulWidget {
  const ListNotificationsScreen({super.key});

  @override
  State<ListNotificationsScreen> createState() => _ListNotificationsScreenState();
}

class _ListNotificationsScreenState extends State<ListNotificationsScreen> {
  late NotificationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<NotificationBloc>(context);
    bloc.add(GetAllNotificationsEvent());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Notifications',

          ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
       NotificationsList(),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllNotificationsEvent());
        },

    ));
  }
}
