import 'package:flutter/material.dart';

import '../../data/models/consultation_model.dart';
import 'consultation_item.dart';

class ConsultationList extends StatelessWidget {
  const ConsultationList({super.key, required this.consultations});
  final List<ConsultationModel> consultations;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => ConsultationItem(
        consultationModel: consultations[index],
      ),
      itemCount: consultations.length,
    );
  }
}
