import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_state.dart';

 import '../../../data/models/furlough_request_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateFurloughStatusScreen extends StatefulWidget {
  final FurloughRequestModel furlough;

  const UpdateFurloughStatusScreen({super.key, required this.furlough});

  @override
  State<UpdateFurloughStatusScreen> createState() => _UpdateFurloughStatusScreenState();
}

class _UpdateFurloughStatusScreenState extends State<UpdateFurloughStatusScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController(text: widget.furlough.status);
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
        title: 'Update Furlough Status',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<FurloughRequestsBloc, FurloughRequestsState>(
          listener: (context, state) {
            if (state is FurloughRequestsSuccess) {
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
                FurloughRequestModel(
                  id: widget.furlough.id,
                  cause: widget.furlough.cause,
                  status: _statusController.text.trim(),
                  startDate: widget.furlough.startDate,
                  endDate: widget.furlough.endDate,
                  covetByType: widget.furlough.covetByType,
                  covetById: widget.furlough.covetById,

                ),
              );
            } else if (state is FurloughRequestsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errmsg,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is FurloughRequestsLoading) {
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
                        BlocProvider.of<FurloughRequestsBloc>(context).add(
                          UpdateFurloughRequestsStatusEvent(
                            furloughRequestId: widget.furlough.id,
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
