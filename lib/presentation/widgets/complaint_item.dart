import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../blocs/complaints_bloc/complaint_event.dart';
import '../../data/models/complaint_model.dart';
import '../../themes.dart';
import '../screens/complaint_screen/complaint_details_screen.dart';

class ComplaintItem extends StatefulWidget {
  const ComplaintItem({super.key, required this.complaintModel});
  final ComplaintModel complaintModel;

  @override
  State<ComplaintItem> createState() => _ComplaintItemState();
}

class _ComplaintItemState extends State<ComplaintItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
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
                builder: (_) => BlocProvider(
                  create: (_) => ComplaintBloc(),
                  child: ComplaintDetailsScreen(
                    complaint: widget.complaintModel,
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                // وصف الشكوى والحالة
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.complaintModel.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkBlue,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Status: ${widget.complaintModel.status}",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkBlue.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // أيقونات الحذف والانتقال
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        BlocProvider.of<ComplaintBloc>(context).add(
                          DeleteComplaintEvent(
                              complaintId: widget.complaintModel.id),
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
                    const SizedBox(width: 12),
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
      ),
    );
  }
}
