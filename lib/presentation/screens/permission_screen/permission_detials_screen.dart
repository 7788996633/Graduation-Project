import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/permission_bloc/permission_bloc.dart';
import '../../../blocs/permission_bloc/permission_event.dart';

import '../../../data/models/permission_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

import 'update_permission_screen.dart';

class PermissionDetailsScreen extends StatefulWidget {
  final PermissionModel permissionModel;

  const PermissionDetailsScreen({super.key, required this.permissionModel});

  @override
  State<PermissionDetailsScreen> createState() => _PermissionDetailsScreenState();
}

class _PermissionDetailsScreenState extends State<PermissionDetailsScreen> {
  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: valueColor ?? Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<PermissionBloc>(context).add(
      GetPermissionByIdEvent(permissionId: widget.permissionModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Permission Details',
      ),
      body: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (state is PermissionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PermissionLoaded) {
            final permission = state.permission;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                elevation: 12,
                shadowColor: Colors.deepPurple.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 80,
                          color: AppColors.darkBlue,
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent.shade200.withOpacity(0.6),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      _buildInfoRow('ID', permission.id.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),

                      _buildInfoRow('Name', permission.name),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),

                      _buildInfoRow('App Route ID', permission.appRouteId.toString()),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),


                      // لو حابب تعرض بيانات pivot:
                      if (permission.pivot != null) ...[
                        _buildInfoRow('Role ID', permission.pivot!.roleId.toString()),
                        Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                        _buildInfoRow('Permission ID', permission.pivot!.permissionId.toString()),
                        Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      ],
                    ],
                  ),
                ),
              ),
            );
          } else if (state is PermissionFail) {
            return Center(child: Text('Error: ${state.errMsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (state is PermissionLoaded) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push<PermissionModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => PermissionBloc(),
                      child: UpdatePermissionScreen(permission: state.permission),
                    ),
                  ),
                );

                if (result != null) {
                  BlocProvider.of<PermissionBloc>(context).add(
                    GetPermissionByIdEvent(permissionId: result.id),
                  );
                }
              },
              icon: const Icon(Icons.edit),
              label: const Text(
                'Edit',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkBlue,
              elevation: 6,
              hoverElevation: 12,
              extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
