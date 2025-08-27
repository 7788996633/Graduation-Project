import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../blocs/complaints_bloc/complaint_event.dart';
import '../../blocs/complaints_bloc/complaint_state.dart';
import '../../constant.dart';
import '../../data/models/complaint_model.dart';
import '../../themes.dart';
import '../screens/complaint_screen/complaint_details_screen.dart';

class ComplaintItem extends StatelessWidget {
  const ComplaintItem({super.key, required this.complaintModel});
  final ComplaintModel complaintModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: BlocConsumer<ComplaintBloc, ComplaintState>(
        listener: (context, state) {
          if (state is ComplaintSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.successMsg),
              ),
            );
          } else if (state is ComplaintFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.errMsg),
              ),
            );
          }
        },
        builder: (context, state) {
          return Card(
            color: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadowColor: AppColors.darkBlue.withOpacity(0.3),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<ComplaintBloc>(context),
                      child: ComplaintDetailsScreen(
                        complaint: complaintModel, myRole: myRole,
                      ),
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                child: Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            complaintModel.description,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Status: ${complaintModel.status}",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.darkBlue.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // أيقونة الحذف والانتقال
                    Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            BlocProvider.of<ComplaintBloc>(context).add(
                              DeleteComplaintEvent(complaintId: complaintModel.id),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.darkBlue,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.darkBlue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.darkBlue,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
