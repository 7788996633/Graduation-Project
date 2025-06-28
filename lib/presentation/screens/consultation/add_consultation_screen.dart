import 'package:flutter/material.dart';

class AddConsultationScreen extends StatefulWidget {
  const AddConsultationScreen({super.key});

  @override
  State<AddConsultationScreen> createState() => _AddConsultationScreenState();
}

class _AddConsultationScreenState extends State<AddConsultationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Consultation"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
