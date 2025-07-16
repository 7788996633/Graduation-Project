import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/lawyer_model.dart';
import '../screens/hr_screen/hiring_request/set_salary_lawyer_screen.dart';
import 'custom_lawyer_item.dart';
import '../../../blocs/hiring_requests/hiring_requests_block.dart';


class LawyerItem extends StatelessWidget {
  const LawyerItem({
    super.key,
    required this.lawyerModel,
  });

  final LawyerModel lawyerModel;

  @override
  Widget build(BuildContext context) {
    return CustomLawyerItem(
      lawyer: lawyerModel,
      trailing: IconButton(
        icon: const Icon(Icons.payments, color: Colors.deepPurple),
        tooltip: 'Set Salary',
        onPressed: () {
          // انتقل إلى شاشة تعيين الراتب مع تمرير معرف المحامي
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<HiringRequestsBloc>(context),
                child: SetSalaryLawyerScreen(lawyerId: lawyerModel.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
