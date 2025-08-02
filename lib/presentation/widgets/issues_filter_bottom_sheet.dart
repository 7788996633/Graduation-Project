import 'package:flutter/material.dart';

import '../../data/filters/issue_filters/issue_filter_factory.dart';

class IssuesFilterBottomSheet extends StatefulWidget {
  const IssuesFilterBottomSheet({super.key});

  @override
  State<IssuesFilterBottomSheet> createState() =>
      _IssuesFilterBottomSheetState();
}

class _IssuesFilterBottomSheetState extends State<IssuesFilterBottomSheet> {
  String? selectedPriority;
  String? selectedStatus;

  final List<String> priority = [
    'medium',
    'critical',
    'high',
    'low',
  ];
  final List<String> status = [
    'open',
    'in_progress',
    'closed',
    'archived',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filter Issues',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(),
            ),
            items: priority
                .map((pr) => DropdownMenuItem(
                      value: pr,
                      child: Text(pr),
                    ))
                .toList(),
            value: selectedPriority,
            onChanged: (value) {
              setState(() {
                selectedPriority = value;
              });
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(),
            ),
            items: status
                .map((st) => DropdownMenuItem(
                      value: st,
                      child: Text(st),
                    ))
                .toList(),
            value: selectedStatus,
            onChanged: (value) {
              setState(() {
                selectedStatus = value;
              });
            },
          ),
          // TextFormField(
          //   decoration: const InputDecoration(
          //     labelText: 'Minimum Experience (years)',
          //     border: OutlineInputBorder(),
          //   ),
          //   keyboardType: TextInputType.number,
          //   onChanged: (val) {
          //     final parsed = int.tryParse(val);
          //     setState(() {
          //       minExperience = parsed;
          //     });
          //   },
          // ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final filter = IssueFilterFactory.build(
                priority: selectedPriority,
                status: selectedStatus,
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
