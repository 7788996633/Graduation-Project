import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_state.dart';
import '../../../data/models/furlough_request_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateFurloughCauseScreen extends StatefulWidget {
  final FurloughRequestModel furlough;

  const UpdateFurloughCauseScreen({super.key, required this.furlough});

  @override
  State<UpdateFurloughCauseScreen> createState() =>
      _UpdateFurloughCauseScreenState();
}

class _UpdateFurloughCauseScreenState
    extends State<UpdateFurloughCauseScreen> {
  late String _cause;
  late FurloughRequestsBloc _bloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cause = widget.furlough.cause;
    _bloc = BlocProvider.of<FurloughRequestsBloc>(context);
  }

  void _onUpdatePressed() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(UpdateFurloughRequestsEvent(
        furloughRequestId: widget.furlough.id,
        cause: _cause.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Furlough Cause'),
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
                  cause: _cause.trim(),
                  status: widget.furlough.status,
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cause:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: _cause,
                      onChanged: (val) => _cause = val,
                      decoration: const InputDecoration(
                        hintText: 'Enter cause',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter cause' : null,
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
                        'Update Cause',
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
