import 'package:flutter/material.dart';
import 'package:graduation/data/models/consultation_model.dart';

import '../screens/consultation/consultation_details_screen.dart';

class ConsultationItem extends StatelessWidget {
  const ConsultationItem({super.key, required this.consultationModel});
  final ConsultationModel consultationModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConsultationDetailsScreen(
                consultationModel: consultationModel,
              ),
            ),
          );
        },
        title: Text(
          consultationModel.resault,
        ),
      ),
    );
  }
}
