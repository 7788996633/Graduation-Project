import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../blocs/session_type_bloc/session_type_event.dart';
import '../../data/models/session_type_model.dart';
import '../../themes.dart';
import '../screens/session_type/session_type_details_screen.dart';

class SessionTypeItem extends StatelessWidget {
  const SessionTypeItem({super.key, required this.sessionTypeModel});
  final SessionTypeModel sessionTypeModel;

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
                  create: (_) => SessionTypeBloc(),
                  child: SessionTypeDetailsScreen(
                    sessionTypeModel: sessionTypeModel,
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
                BlocProvider.of<SessionTypeBloc>(context).add(
                  DeleteSessionTypeEvent(sessionTypeId: sessionTypeModel.id),
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: AppColors.darkBlue,
                size: 28,
              ),
              tooltip: 'Delete Session Type',
            ),
          ),
          title: Text(
            sessionTypeModel.type,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlue,
              letterSpacing: 0.5,
            ),
          ),
          subtitle: Text(
            'Session Type',
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
