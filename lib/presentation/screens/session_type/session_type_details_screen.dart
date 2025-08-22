import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';

import '../../../data/models/session_type_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import 'update_session_type.dart';

class SessionTypeDetailsScreen extends StatefulWidget {
  final SessionTypeModel sessionTypeModel;

  const SessionTypeDetailsScreen({super.key, required this.sessionTypeModel});

  @override
  State<SessionTypeDetailsScreen> createState() => _SessionTypeDetailsScreenState();
}

class _SessionTypeDetailsScreenState extends State<SessionTypeDetailsScreen> {
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

    BlocProvider.of<SessionTypeBloc>(context).add(
      GetSessionTypeByIdEvent(sessionTypeId: widget.sessionTypeModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: CustomActionAppBar(
        title: 'Session Type Details',
      ),
      body: BlocBuilder<SessionTypeBloc, SessionTypeState>(
        builder: (context, state) {
          if (state is SessionTypeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SessionTypeLoaded) {
            final sessionType = state.session;

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
                          Icons.event_note_outlined,
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

                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Type', sessionType.type),
                      Divider(color: Colors.deepPurple.shade100, thickness: 1.5),
                      _buildInfoRow('Points', sessionType.points.toString(), valueColor: AppColors.darkBlue),
                      Divider(color: Colors.blueAccent.shade100, thickness: 1.5),
                      _buildInfoRow('Description', sessionType.description),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is SessionTypeFail) {
            return Center(child: Text('Error: ${state.errMsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: BlocBuilder<SessionTypeBloc, SessionTypeState>(
        builder: (context, state) {
          if (state is SessionTypeLoaded) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push<SessionTypeModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => SessionTypeBloc(),
                      child: UpdateSessionTypeScreen(sessionType: state.session),
                    ),
                  ),
                );

                if (result != null) {
                  // إعادة تحميل البيانات بعد التحديث
                  BlocProvider.of<SessionTypeBloc>(context).add(
                    GetSessionTypeByIdEvent(sessionTypeId: result.id),
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
