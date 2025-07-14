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

  const CommonConsultationDetailsScreen({super.key, required this.consultationModel});

  @override
  State<CommonConsultationDetailsScreen> createState() => _CommonConsultationDetailsScreenState();
}

class _CommonConsultationDetailsScreenState extends State<CommonConsultationDetailsScreen> {
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
      backgroundColor: Colors.white,
      appBar:CustomActionAppBar(
        title: 'Common Consultation details',),
      body: BlocBuilder<CommonConsultationBloc, CommonConsultationState>(
        builder: (context, state) {
          if (state is CommonConsultationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommonConsultationLoadedSuccessfully) {
            final consultation = state.consultationModel;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Consultation Details Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Consultation ID and Tag
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Consultation ID: ${consultation.id}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.darkBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'General Consultation',
                                  style: TextStyle(
                                    color: AppColors.darkBlue,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Question Section
                          const Text(
                            'Question:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Text(
                              consultation.question,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Answer Section
                          const Text(
                            'Answer:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Text(
                              consultation.answer.isEmpty ? 'No answer yet' : consultation.answer,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CommonConsultationFail) {
            return Center(child: Text('An error occurred: ${state.errmsg}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: BlocBuilder<CommonConsultationBloc, CommonConsultationState>(
        builder: (context, state) {
          if (state is CommonConsultationLoadedSuccessfully) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.push<CommonConsultationModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => CommonConsultationBloc(),
                      child: UpdateCommonConsultationScreen(consultation: state.consultationModel),
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
