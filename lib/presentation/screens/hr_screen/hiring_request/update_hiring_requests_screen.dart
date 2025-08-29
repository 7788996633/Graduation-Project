import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../../../blocs/hiring_requests/hiring_requests_state.dart';
import '../../../../data/models/hiring_request_model.dart';
import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';

class UpdateHiringRequestStatusScreen extends StatefulWidget {
  final HiringRequestModel hiringRequest;

  const UpdateHiringRequestStatusScreen({
    Key? key,
    required this.hiringRequest,
  }) : super(key: key);

  @override
  State<UpdateHiringRequestStatusScreen> createState() =>
      _UpdateHiringRequestStatusScreenState();
}

class _UpdateHiringRequestStatusScreenState
    extends State<UpdateHiringRequestStatusScreen> {
  String? selectedStatus;
  late HiringRequestsBloc _bloc;

  final List<String> statusOptions = [
    'archived',
    'canceled',
    'closed',
    'published',
    'draft',
  ];

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.hiringRequest.status;
    _bloc = HiringRequestsBloc();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
    if (selectedStatus != null) {
      _bloc.add(
        UpdateHiringRequest(
          hiringRequestId: widget.hiringRequest.id,
          status: selectedStatus!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HiringRequestsBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Hiring Status'),
        body: BlocConsumer<HiringRequestsBloc, HiringRequestsState>(
          listener: (context, state) {
            if (state is HiringRequestsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successmsg}')),
              );

              Navigator.pop(
                context,
                HiringRequestModel(
                  id: widget.hiringRequest.id,
                  jopTitle: widget.hiringRequest.jopTitle,
                  type: widget.hiringRequest.type,
                  status: selectedStatus!, description:widget.hiringRequest.description,

                ),
              );
            } else if (state is HiringRequestsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errmsg}')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is HiringRequestsLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Job Title: ${widget.hiringRequest.jopTitle}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Type: ${widget.hiringRequest.type}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select New Status',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...statusOptions.map((status) {
                      return RadioListTile<String>(
                        title: Text(status),
                        value: status,
                        groupValue: selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value;
                          });
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 30),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                      onPressed: _onUpdatePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                      ),
                      child: const Text(
                        'Update Status',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
