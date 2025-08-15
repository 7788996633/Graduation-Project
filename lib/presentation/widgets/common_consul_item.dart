import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/common_consultation_bloc/common _consultation_bloc.dart';
import '../../blocs/common_consultation_bloc/common _consultation_event.dart';

import '../../constant.dart';
import '../../data/models/common _consultation_model.dart';
import '../../themes.dart';
import '../screens/common_consulation/common_consul_detials.dart';

class CommonConsultationItem extends StatelessWidget {
  const CommonConsultationItem({super.key, required this.consultationModel});
  final CommonConsultationModel consultationModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey, width: isLight ? 0 : 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => CommonConsultationBloc(),
                child: CommonConsultationDetailsScreen(
                  consultationModel: consultationModel,
                ),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFCFD8DC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // صورة الشركة
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/download.jpeg',
                      height: 32,
                      width: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // النصوص (Question + محتوى السؤال)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: getCurrentTheme()['CommonConsultationText'],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          consultationModel.question,
                          style: TextStyle(
                            fontSize: 15,
                            color: getCurrentTheme()['BoldText'],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (myRole == 'admin')
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        BlocProvider.of<CommonConsultationBloc>(context).add(
                          DeleteCommonConsultationEvent(
                              id: consultationModel.id),
                        );
                      },
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: getCurrentTheme()['BackGorund'],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/grad.jpg', //assets/images/grad.jpg
                      height: 32,
                      width: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // النصوص (Answer + محتوى الجواب)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Answer:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:
                                isLight ? AppColors.darkBlue : AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          consultationModel.answer.isEmpty
                              ? 'No answer yet'
                              : consultationModel.answer,
                          style: TextStyle(
                            fontSize: 15,
                            color: getCurrentTheme()['BoldText'],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
