import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';


import '../../../constant.dart';
import '../../../data/models/session_type_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';

class UpdateSessionTypeScreen extends StatefulWidget {
  final SessionTypeModel sessionType;

  const UpdateSessionTypeScreen({super.key, required this.sessionType});

  @override
  State<UpdateSessionTypeScreen> createState() =>
      _UpdateSessionTypeScreenState();
}

class _UpdateSessionTypeScreenState extends State<UpdateSessionTypeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _pointsController;

  @override
  void initState() {
    super.initState();
    _pointsController =
        TextEditingController(text: widget.sessionType.points.toString());
  }

  @override
  void dispose() {
    _pointsController.dispose();
    super.dispose();
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      final points = int.tryParse(_pointsController.text.trim()) ?? 0;
      print('Submitting updated points: $points');
      BlocProvider.of<SessionTypeBloc>(context).add(
        UpdateSessionTypeEvent(
          sessionTypeId: widget.sessionType.id!,
          points: points,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomActionAppBar(
        title: 'Update Session Type',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<SessionTypeBloc, SessionTypeState>(
          listener: (context, state) {
            if (state is SessionTypeSuccess) {
              print('Updated SessionType: '
                  'id=${widget.sessionType.id}, '
                  'points=${_pointsController.text.trim()}');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMsg,
                      style: const TextStyle(fontSize: 16)),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(
                context,
                SessionTypeModel(
                  id: widget.sessionType.id,
                  type: widget.sessionType.type,
                  description: widget.sessionType.description,
                  points: int.tryParse(_pointsController.text.trim()) ??
                      widget.sessionType.points,
                  date: widget.sessionType.date,
                ),
              );
            } else if (state is SessionTypeFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMsg,
                      style: const TextStyle(fontSize: 16)),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SessionTypeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _pointsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Points'),
                    validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter points' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitUpdate,
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
