import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../blocs/lawyer_bloc/lawyer_event.dart';
import '../../blocs/lawyer_bloc/lawyer_state.dart';
import '../../data/models/consultation_model.dart';
import '../../data/models/lawyer_model.dart';
import '../../themes.dart';
import '../screens/consultation/consultation_details_screen.dart';

class MyConsultationsLawyerItem extends StatelessWidget {
  const MyConsultationsLawyerItem({super.key, required this.consultationModel});
  final ConsultationModel consultationModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LawyerBloc()..add(GetLawyerByIdEvent(lawyerId: consultationModel.lawyerId)),
      child: Padding(
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ConsultationDetailsScreen(
                    consultationModel: consultationModel,
                  ),
                ),
              );
            },
            leading: Container(
              decoration: BoxDecoration(
                color: AppColors.darkBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: AppColors.darkBlue,
                size: 28,
              ),
            ),
            title: Text(
              consultationModel.resault,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.darkBlue,
                letterSpacing: 0.5,
              ),
            ),
            subtitle: BlocBuilder<LawyerBloc, LawyerState>(
              builder: (context, state) {
                if (state is LawyerLoadedSuccessfully) {
                  final LawyerModel lawyer = state.lawyerModel;
                  return Text(
                    lawyer.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.darkBlue.withOpacity(0.6),
                    ),
                  );
                } else if (state is LawyerFail) {
                  return Text(
                    'Failed to load lawyer',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.withOpacity(0.6),
                    ),
                  );
                } else {
                  return const Text(
                    'Loading...',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  );
                }
              },
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.darkBlue.withOpacity(0.7),
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
