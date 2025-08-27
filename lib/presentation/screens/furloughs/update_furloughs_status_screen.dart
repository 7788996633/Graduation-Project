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
  State<UpdateFurloughStatusScreen> createState() =>
      _UpdateFurloughStatusScreenState();
}

class _UpdateFurloughStatusScreenState
    extends State<UpdateFurloughStatusScreen> {
  late String _status;
  late FurloughRequestsBloc _bloc;

  final _formKey = GlobalKey<FormState>();

  final List<String> _statusOptions = [
    'pending',
    'approved',
    'rejected',
  ];

  @override
  void initState() {
    super.initState();
    _status = widget.furlough.status;
    _bloc = BlocProvider.of<FurloughRequestsBloc>(context);
  }

  void _onUpdatePressed() {
    _bloc.add(UpdateFurloughRequestsStatusEvent(
      furloughRequestId: widget.furlough.id,
      status: _status.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Furlough Status'),
        body: BlocConsumer<FurloughRequestsBloc, FurloughRequestsState>(
          listener: (context, state) {
            if (state is FurloughRequestsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ ${state.successmsg}'),
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.pop(
                context,
                FurloughRequestModel(
                  id: widget.furlough.id,
                  cause: widget.furlough.cause,
                  status: _status.trim(),
                  startDate: widget.furlough.startDate,
                  endDate: widget.furlough.endDate,
                  covetByType: widget.furlough.covetByType,
                  covetById: widget.furlough.covetById,
                ),
              );
            } else if (state is FurloughRequestsFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('❌ ${state.errmsg}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is FurloughRequestsLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: _statusOptions
                        .map(
                          (option) => RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: _status,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _status = val;
                            });
                          }
                        },
                      ),
                    )
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: _onUpdatePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Status',
                      style: TextStyle(color: Colors.white),
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
