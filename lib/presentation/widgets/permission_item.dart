import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/permission_bloc/permission_bloc.dart';
import '../../blocs/permission_bloc/permission_event.dart';
import '../../data/models/permission_model.dart';
import '../../themes.dart';

class PermissionItem extends StatelessWidget {
  const PermissionItem({super.key, required this.permissionModel});
  final PermissionModel permissionModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadowColor: AppColors.darkBlue.withOpacity(0.3),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
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
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    permissionModel.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.darkBlue,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
