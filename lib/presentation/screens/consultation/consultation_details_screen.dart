import 'package:flutter/material.dart';

import '../../../data/models/consultation_model.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  const ConsultationDetailsScreen({super.key, required this.consultationModel});
  final ConsultationModel consultationModel;
  @override
  State<ConsultationDetailsScreen> createState() =>
      _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Card(
            child: Text(
              widget.consultationModel.resault,
            ),
          ),
        ],
      ),
    );
  }
}
