import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';

import '../../../data/models/session_type_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateSessionTypeScreen extends StatefulWidget {
  final SessionTypeModel sessionType;

  const UpdateSessionTypeScreen({super.key, required this.sessionType});

  @override
  State<UpdateSessionTypeScreen> createState() => _UpdateSessionTypeScreenState();
}

class _UpdateSessionTypeScreenState extends State<UpdateSessionTypeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _pointsController;

  bool _isSaving = false;
  bool _hasRequestedFetch = false;

  @override
  void initState() {
    super.initState();
    _pointsController = TextEditingController(text: widget.sessionType.points?.toString() ?? '');
  }

  @override
  void dispose() {
    _pointsController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      final points = int.tryParse(_pointsController.text.trim());
      if (points == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid number for points'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isSaving = true;
        _hasRequestedFetch = false;
      });

      BlocProvider.of<SessionTypeBloc>(context).add(
        UpdateSessionTypeEvent(
          sessionTypeId: widget.sessionType.id,
          points: points,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(title: 'Update Session Type'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<SessionTypeBloc, SessionTypeState>(
          listener: (context, state) {
            if (state is SessionTypeSuccess && !_hasRequestedFetch) {
              _hasRequestedFetch = true;
              BlocProvider.of<SessionTypeBloc>(context).add(
                GetSessionTypeByIdEvent(sessionTypeId: widget.sessionType.id),
              );
            } else if (state is SessionTypeLoaded) {
              setState(() {
                _isSaving = false;
              });

              Navigator.pop(context, state.session);
            } else if (state is SessionTypeFail) {
              setState(() {
                _isSaving = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMsg),
                  backgroundColor: Colors.red,
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
                    controller: _pointsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Points',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter points';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    enabled: !_isSaving,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _submitUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                      ),
                      child: _isSaving
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
