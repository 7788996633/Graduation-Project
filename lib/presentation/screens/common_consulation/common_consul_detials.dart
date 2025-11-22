import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_event.dart';
import '../../../blocs/common_consultation_bloc/common _consultation_state.dart';

import '../../../data/models/common _consultation_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import 'update_common_consul.dart';

class CommonConsultationDetailsScreen extends StatefulWidget {
  final CommonConsultationModel consultationModel;

  const CommonConsultationDetailsScreen(
      {super.key, required this.consultationModel});

  @override
  State<CommonConsultationDetailsScreen> createState() =>
      _CommonConsultationDetailsScreenState();
}

class _CommonConsultationDetailsScreenState
    extends State<CommonConsultationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CommonConsultationBloc>(context).add(
      GetCommonConsultationById(id: widget.consultationModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomActionAppBar(
        title: 'Common Consultation details',
      ),
      body: BlocBuilder<CommonConsultationBloc, CommonConsultationState>(
        builder: (context, state) {
          if (state is CommonConsultationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommonConsultationLoadedSuccessfully) {
            final consultation = state.consultationModel;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: getCurrentTheme()['BackGorund'],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, width: isLight.value ? 0 : 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // حذف Consultation ID وحافظنا على نوع الاستشارة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'General Consultation',
                              style: TextStyle(
                                color: !isLight.value
                                    ? AppColors.white
                                    : AppColors.darkBlue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // السؤال مع الصورة في bubble
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/download.jpeg', // استبدل بالمسار المناسب لصورة السؤال
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Question:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isLight.value
                                        ? AppColors.white
                                        : AppColors.darkBlue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue.shade50,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    consultation.question,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        height: 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // الإجابة مع الصورة في bubble
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/grad.jpg', // استبدل بالمسار المناسب لصورة الإجابة
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Answer:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isLight.value
                                        ? AppColors.white
                                        : AppColors.darkBlue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    consultation.answer.isEmpty
                                        ? 'No answer yet'
                                        : consultation.answer,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        height: 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CommonConsultationFail) {
            return Center(child: Text('An error occurred: ${state.errmsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton:
          BlocBuilder<CommonConsultationBloc, CommonConsultationState>(
        builder: (context, state) {
          if (state is CommonConsultationLoadedSuccessfully) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push<CommonConsultationModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => CommonConsultationBloc(),
                      child: UpdateCommonConsultationScreen(
                          consultation: state.consultationModel),
                    ),
                  ),
                );

                if (result != null) {
                  BlocProvider.of<CommonConsultationBloc>(context).add(
                    GetCommonConsultationById(id: result.id),
                  );
                }
              },
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                'Edit Consultation',
                style: TextStyle(
                  fontSize: 16,
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
