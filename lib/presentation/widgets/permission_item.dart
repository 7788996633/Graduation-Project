import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/permission_bloc/permission_bloc.dart';
import '../../blocs/permission_bloc/permission_event.dart';
import '../../data/models/permission_model.dart';
import '../../themes.dart';
import '../screens/permission_screen/permission_detials_screen.dart';

class PermissionItem extends StatelessWidget {
  const PermissionItem({super.key, required this.permissionModel});
  final PermissionModel permissionModel;

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
                builder: (_) => BlocProvider(
                  create: (_) => PermissionBloc(),
                  child: PermissionDetailsScreen(
                    permissionModel: permissionModel,
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
                BlocProvider.of<PermissionBloc>(context).add(
                  DeletePermissionEvent(permissionId: permissionModel.id),
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: AppColors.darkBlue,
                size: 28,
              ),
              tooltip: 'Delete Permission',
            ),
          ),
          title: Text(
            permissionModel.name,  // تم التغيير هنا ليعرض الاسم
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlue,
              letterSpacing: 0.5,
            ),
          ),
          subtitle: Text(
            'Permission (App Route ID: ${permissionModel.appRouteId})', // عرض app_route_id كمثال
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
