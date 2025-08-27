import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../blocs/complaints_bloc/complaint_event.dart';
import '../../blocs/complaints_bloc/complaint_state.dart';
import '../../constant.dart';
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
  late String status;

  @override
  void initState() {
    super.initState();
    status = widget.complaintModel.status;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ComplaintBloc>(context),
                    child: ComplaintDetailsScreen(
                      complaint: widget.complaintModel,
                      myRole: myRole,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // عنوان المستخدم + الحالة
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.darkBlue.withOpacity(0.2),
                          child: Text(
                            widget.complaintModel.userName.isNotEmpty
                                ? widget.complaintModel.userName[0].toUpperCase()
                                : 'U',
                            style: const TextStyle(color: AppColors.darkBlue),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.complaintModel.userName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkBlue,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Status: $status",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (myRole != null && myRole.toLowerCase() == 'admin')
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<ComplaintBloc>(context).add(
                                DeleteComplaintEvent(
                                    complaintId: widget.complaintModel.id),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.darkBlue,
                              size: 20,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      widget.complaintModel.description.length > 100
                          ? '${widget.complaintModel.description.substring(0, 100)}...'
                          : widget.complaintModel.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
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

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
