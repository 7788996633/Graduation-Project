import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../blocs/permission_bloc/permission_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/permission_list.dart';
import '../../widgets/refresh_button.dart';

import 'add_permission_screen.dart';

class ListPermissionsScreen extends StatefulWidget {
const ListPermissionsScreen({super.key});

@override
State<ListPermissionsScreen> createState() => _ListPermissionsScreenState();
}

class _ListPermissionsScreenState extends State<ListPermissionsScreen> {
late PermissionBloc bloc;

@override
void initState() {
super.initState();
bloc = BlocProvider.of<PermissionBloc>(context);
bloc.add(
GetAllPermissionsEvent(),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: AppColors.scaffold,
appBar: CustomActionAppBar(
title: 'Permissions',


),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
children: [
const SizedBox(height: 20),
PermissionList(bloc: bloc),
],
),
),
floatingActionButton: RefreshButton(
onPressed: () {
bloc.add(
GetAllPermissionsEvent(),
);
},
),
);
}
}  