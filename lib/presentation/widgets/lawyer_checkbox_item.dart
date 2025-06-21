import 'package:flutter/material.dart';

import '../../data/models/lawyer_model.dart';
import 'custom_lawyer_item.dart';

class LawyerCheckboxItem extends StatefulWidget {
  const LawyerCheckboxItem({
    super.key,
    required this.lawyerModel,
    required this.isChecked,
    required this.onChanged,
  });

  final LawyerModel lawyerModel;
  final bool isChecked;
  final void Function(bool?) onChanged;

  @override
  State<LawyerCheckboxItem> createState() => _LawyerCheckboxItemState();
}

class _LawyerCheckboxItemState extends State<LawyerCheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return CustomLawyerItem(
      lawyer: widget.lawyerModel,
      trailing: Checkbox(
        value: widget.isChecked,
        onChanged: widget.onChanged,
        activeColor: Colors.deepPurple, // لون خلفية التشيك بوكس عند التحديد
        checkColor: Colors.white, // لون علامة الصح داخل التشيك بوكس
        fillColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(
              WidgetState.selected,
            )) {
              return Colors.deepPurple
                  .shade700; // لون التشيك بوكس لما يكون محدد (داكن أكثر)
            }
            return null; // اللون الافتراضي لما ما يكون محدد
          },
        ),
      ),
    );
  }
}
