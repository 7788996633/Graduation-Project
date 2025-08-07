import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/user_bloc/user_bloc.dart';
 import '../../../../themes.dart';

import '../../../widgets/clients_list1.dart'; // تم تعديل اسم الويدجيت
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/refresh_button.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({super.key});

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  late UserBloc bloc;
  int? selectedUserId; // تعريف المتغير لحفظ المستخدم المختار

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<UserBloc>(context);
    bloc.add(GetAllClients()); // تحميل العملاء عند بداية الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Users',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
           ClientsList1(
               onUserSelected: (userId) {
                setState(() {
                  selectedUserId = userId;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllClients()); // إعادة تحميل العملاء
        },
      ),
    );
  }
}
