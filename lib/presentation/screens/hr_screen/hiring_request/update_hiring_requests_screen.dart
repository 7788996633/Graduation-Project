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

  const UpdateHiringRequestStatusScreen({super.key, required this.hiringRequest});

  @override
  State<UpdateHiringRequestStatusScreen> createState() =>
      _UpdateHiringRequestStatusScreenState();
}

class _UpdateHiringRequestStatusScreenState
    extends State<UpdateHiringRequestStatusScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController(text: widget.hiringRequest.status);
  }

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Update Hiring Request Status',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<HiringRequestsBloc, HiringRequestsState>(
          listener: (context, state) {
            if (state is HiringRequestsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.successmsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(
                context,
                HiringRequestModel(
                  id: widget.hiringRequest.id,
                  status: _statusController.text.trim(),
                  jopTitle:widget.hiringRequest.jopTitle,
                   type: widget.hiringRequest.type,
                  description: widget.hiringRequest.description,
                ),
              );
            } else if (state is HiringRequestsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errmsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is HiringRequestsLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Loading ...",
                    style: TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.grey,
                ),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _statusController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(labelText: 'Status'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter status' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<HiringRequestsBloc>(context).add(
                          UpdateHiringRequest(
                            hiringRequestId: widget.hiringRequest.id,
                            status: _statusController.text.trim(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                    ),
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
