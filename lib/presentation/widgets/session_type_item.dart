import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../blocs/session_type_bloc/session_type_event.dart';

import '../../data/models/session_type_model.dart';
import '../../themes.dart';
import '../screens/session_type/session_type_details_screen.dart';

class SessionTypeItem extends StatefulWidget {
  const SessionTypeItem({super.key, required this.sessionTypeModel});
  final SessionTypeModel sessionTypeModel;

  @override
  State<SessionTypeItem> createState() => _SessionTypeItemState();
}

class _SessionTypeItemState extends State<SessionTypeItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: BlocConsumer<SessionTypeBloc, SessionTypeState>(
        listener: (context, state) {
          if (state is SessionTypeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.successMsg),
              ),
            );
          } else if (state is SessionTypeFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.errMsg),
              ),
            );
          }
        },
        builder: (context, state) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<SessionTypeBloc>(context),
                    child: SessionTypeDetailsScreen(
                        sessionTypeModel: widget.sessionTypeModel),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.darkBlue.withOpacity(0.2),
                      child: const Icon(
                        Icons.event_note,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.sessionTypeModel.type,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<SessionTypeBloc>().add(
                          DeleteSessionTypeEvent(
                              sessionTypeId: widget.sessionTypeModel.id),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.darkBlue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.darkBlue,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
