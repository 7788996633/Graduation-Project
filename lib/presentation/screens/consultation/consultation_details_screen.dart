import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_event.dart';
import '../../../blocs/lawyer_bloc/lawyer_state.dart';
import '../../../data/models/consultation_model.dart';
import '../../../themes.dart';

class ConsultationDetailsScreen extends StatelessWidget {
  const ConsultationDetailsScreen({super.key, required this.consultationModel});
  final ConsultationModel consultationModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      LawyerBloc()..add(GetLawyerByIdEvent(lawyerId: consultationModel.lawyerId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("تفاصيل الاستشارة"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// اسم المحامي
              BlocBuilder<LawyerBloc, LawyerState>(
                builder: (context, state) {
                  if (state is LawyerLoadedSuccessfully) {
                    return Text(
                      "المحامي: ${state.lawyerModel.name}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    );
                  } else if (state is LawyerFail) {
                    return const Text(
                      "فشل تحميل المحامي",
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20),

              /// نتيجة الاستشارة
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    consultationModel.resault,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
