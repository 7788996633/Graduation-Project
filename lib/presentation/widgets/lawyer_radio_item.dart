import 'package:flutter/material.dart';

import '../../data/models/lawyer_model.dart';
import 'custom_lawyer_item.dart';

class LawyerRadioItem extends StatefulWidget {
  const LawyerRadioItem(
      {super.key,
      required this.lawyerModel,
      this.groupValue,
      required this.onChanged});
  final LawyerModel lawyerModel;
  final int? groupValue;
  final void Function(int?) onChanged;

  @override
  State<LawyerRadioItem> createState() => _LawyerRadioItemState();
}

class _LawyerRadioItemState extends State<LawyerRadioItem> {
  @override
  Widget build(BuildContext context) {
    return CustomLawyerItem(
      lawyer: widget.lawyerModel,
      trailing: Radio<int>(
        value: widget.lawyerModel.id,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
