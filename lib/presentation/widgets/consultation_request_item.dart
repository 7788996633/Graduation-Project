import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import '../../blocs/Consultation_Request_bloc/consultation_request_bloc.dart';
import '../../blocs/consultations_bloc/consultation_bloc.dart';
import '../../data/models/cons_req_model.dart';
import '../screens/consultation/add_consultation_screen.dart';

class ConsultationRequestItem extends StatefulWidget {
  const ConsultationRequestItem(
      {super.key,
      required this.consReqModel,
      required this.consultationRequestBloc});
  final ConsReqModel consReqModel;
  final ConsultationRequestBloc consultationRequestBloc;
  @override
  State<ConsultationRequestItem> createState() =>
      _ConsultationRequestItemState();
}

class _ConsultationRequestItemState extends State<ConsultationRequestItem> {
  String formatDate(DateTime date) {
    String day = DateFormat('d').format(date);
    String month = DateFormat('M').format(date);
    String year = DateFormat('yyyy').format(date);

    return '$day/$month/$year';
  }

  bool isEditing = false;
  late ConsReqModelStatus selectedStatus;
  @override
  void initState() {
    super.initState();
    selectedStatus = stringToStatus(widget.consReqModel.status);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultationRequestBloc, ConsultationRequestState>(
      listener: (context, state) {
        if (state is ConsultationRequestSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("✅ ${state.successmsg}")),
          );
          // إعادة تحميل القائمة بعد الحذف
          widget.consultationRequestBloc
              .add(GetAllConsultationRequestStatusEvent());
        } else if (state is ConsultationRequestFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ ${state.errmsg}")),
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            if (widget.consReqModel.isLocked == 1) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text("⚠️ هذه الاستشارة قيد المراجعة من محامي آخر")),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => ConsultationBloc(),
                    child: AddConsultationScreen(
                      consultationRequestModel: widget.consReqModel,
                    ),
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(
              10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    10,
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: widget.consReqModel.status ==
                                        'pending'
                                    ? Colors.yellowAccent
                                    : widget.consReqModel.status == 'approved'
                                        ? Colors.greenAccent
                                        : widget.consReqModel.status ==
                                                'rejected'
                                            ? Colors.redAccent
                                            : Colors.redAccent,
                                radius: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              isEditing
                                  ? DropdownButton<ConsReqModelStatus>(
                                      value: selectedStatus,
                                      items: ConsReqModelStatus.values
                                          .map((value) {
                                        return DropdownMenuItem<
                                            ConsReqModelStatus>(
                                          value: value,
                                          child: Text(statusToString(value)),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            selectedStatus = newValue;
                                          });
                                        }
                                      },
                                    )
                                  : Text(
                                      statusToString(selectedStatus),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                            ],
                          ),
                          Text(
                            widget.consReqModel.user.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            widget.consReqModel.isLocked == 0
                                ? Icons.lock_open
                                : Icons.lock,
                            color: widget.consReqModel.isLocked == 0
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),
                          Text(
                            widget.consReqModel.subject,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDate(
                              widget.consReqModel.date,
                            ),
                          ),
                          Text(
                            widget.consReqModel.details,
                          ),
                        ],
                      ),
                      // if (isEditing)
                      //   Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       IconButton(
                      //         icon: Icon(Icons.edit, color: Colors.blue),
                      //         onPressed: () {
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (_) => EditConsultationPage(
                      //                   request: widget.consReqModel),
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //       IconButton(
                      //         icon: Icon(Icons.delete, color: Colors.red),
                      //         onPressed: () {
                      //           showDialog(
                      //             context: context,
                      //             builder: (context) => AlertDialog(
                      //               title: Text("تأكيد الحذف"),
                      //               content: Text(
                      //                   "هل أنت متأكد من حذف هذه الاستشارة؟"),
                      //               actions: [
                      //                 TextButton(
                      //                   onPressed: () => Navigator.pop(context),
                      //                   child: Text("إلغاء"),
                      //                 ),
                      //                 TextButton(
                      //                   onPressed: () {
                      //                     widget.consultationRequestBloc.add(
                      //                       DeleteConsultationRequestStatusEvent(
                      //                           id: widget.consReqModel.id),
                      //                     );
                      //                     Navigator.pop(context);
                      //                     widget.consultationRequestBloc.add(
                      //                       GetAllConsultationRequestStatusEvent(),
                      //                     );
                      //                   },
                      //                   child: Text("نعم، احذف"),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      BlocConsumer<ConsultationRequestBloc,
                          ConsultationRequestState>(
                        listener: (context, state) {
                          if (state is ConsultationRequestSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.successmsg,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state is ConsultationRequestFail) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.errmsg,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon:
                                    Icon(isEditing ? Icons.check : Icons.edit),
                                onPressed: () {
                                  if (isEditing) {
                                    if (statusToString(selectedStatus)
                                            .toLowerCase() !=
                                        widget.consReqModel.status
                                            .toLowerCase()) {
                                      BlocProvider.of<ConsultationRequestBloc>(
                                              context)
                                          .add(
                                        UpdateConsultationRequestStatusEvent(
                                          id: widget.consReqModel.id,
                                          status: statusToString(selectedStatus)
                                              .toLowerCase(),
                                        ),
                                      );
                                    }
                                    print('Saving status: $selectedStatus');
                                  }
                                  setState(() {
                                    isEditing = !isEditing;
                                  });
                                },
                              ),
                              if (isEditing) ...[
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("تأكيد الحذف"),
                                        content: Text(
                                            "هل أنت متأكد من حذف هذه الاستشارة؟"),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("إلغاء"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              widget.consultationRequestBloc
                                                  .add(
                                                DeleteConsultationRequestStatusEvent(
                                                    id: widget.consReqModel.id),
                                              );
                                              Navigator.pop(context);
                                              widget.consultationRequestBloc
                                                  .add(
                                                GetAllConsultationRequestStatusEvent(),
                                              );
                                            },
                                            child: Text("نعم، احذف"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ListTile(
            //   title: Text(
            //     widget.consReqModel.user.name,
            //     textAlign: TextAlign.right,
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   subtitle: Column(
            //     children: [
            //       Text(
            //         widget.consReqModel.subject,
            //         textAlign: TextAlign.right,
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       Text(
            //         formatDate(widget.consReqModel.date),
            //       ),
            //       Text(
            //         widget.consReqModel.status,
            //       ),
            //     ],
            //   ),
            //   leading: Icon(
            //     widget.consReqModel.isLocked == 0 ? Icons.lock_open : Icons.lock,
            //     color: widget.consReqModel.isLocked == 0
            //         ? Colors.greenAccent
            //         : Colors.redAccent,
            //   ),
            // trailing: R
          ),
        );
      },
    );
  }
}
