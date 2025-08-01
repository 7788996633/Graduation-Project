import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../../../blocs/hiring_requests/hiring_requests_state.dart';

import '../../../../data/models/hiring_request_model.dart';

class UpdateHiringRequestStatusScreen extends StatefulWidget {
  final HiringRequestModel hiringRequest;

  const UpdateHiringRequestStatusScreen({super.key, required this.hiringRequest});

  @override
  State<UpdateHiringRequestStatusScreen> createState() => _UpdateHiringRequestStatusScreenState();
}

class _UpdateHiringRequestStatusScreenState extends State<UpdateHiringRequestStatusScreen> {
  String? selectedStatus;

  final List<String> statusOptions = [
    'Pending',
    'Accepted',
    'Rejected',
    'Under Review',
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.hiringRequest.status;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HiringRequestsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Update Hiring Status'),
          backgroundColor: Colors.blueGrey,
        ),
        body: BlocConsumer<HiringRequestsBloc, HiringRequestsState>(
          listener: (context, state) {
            if (state is HiringRequestsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successmsg}')),
              );
              Navigator.pop(
                context,
              );
            } else if (state is HiringRequestsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errmsg}')),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Job Title: ${widget.hiringRequest.jopTitle}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Type: ${widget.hiringRequest.type}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                  SizedBox(height: 30),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    items: statusOptions.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select New Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  state is HiringRequestsLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      if (selectedStatus != null) {
                        BlocProvider.of<HiringRequestsBloc>(context).add(
                          UpdateHiringRequest(
                            hiringRequestId: widget.hiringRequest.id,
                            status: selectedStatus!,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: Text('Update Status', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
