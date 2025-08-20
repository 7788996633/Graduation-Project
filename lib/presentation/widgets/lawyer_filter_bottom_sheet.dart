import 'package:flutter/material.dart';
import '../../data/filters/lawyer_filters/lawyer_filter_factory.dart';

class LawyerFilterBottomSheet extends StatefulWidget {
  const LawyerFilterBottomSheet({super.key});

  @override
  State<LawyerFilterBottomSheet> createState() =>
      _LawyerFilterBottomSheetState();
}

class _LawyerFilterBottomSheetState extends State<LawyerFilterBottomSheet> {
  String? selectedSpecialization;
  int? minExperience;

  final List<String> specializations = [
    'Criminal',
    'Civil',
    'Corporate',
    'Family',
  ]; // عدل أو أضف حسب تخصصات المحامين عندك

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter Lawyers',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Specialization',
              border: OutlineInputBorder(),
            ),
            items: specializations
                .map((spec) => DropdownMenuItem(
                      value: spec,
                      child: Text(spec),
                    ))
                .toList(),
            value: selectedSpecialization,
            onChanged: (value) {
              setState(() {
                selectedSpecialization = value;
              });
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Minimum Experience (years)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              final parsed = int.tryParse(val);
              setState(() {
                minExperience = parsed;
              });
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final filter = LawyerFilterFactory.build(
                specialization: selectedSpecialization,
                minExperience: minExperience,
              );
              Navigator.pop(context, filter);
            },
            child: const Text("Apply Filter"),
          ),
        ],
      ),
    );
  }
}
