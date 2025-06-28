import 'package:flutter/material.dart';
import 'package:graduation/data/models/consultation_model.dart';
import 'package:graduation/presentation/widgets/consultation_item.dart';

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
