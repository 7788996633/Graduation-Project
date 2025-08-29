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
  late TextEditingController _pointsController;
  late SessionTypeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _pointsController = TextEditingController(
        text: widget.sessionType.points?.toString() ?? '');
    _bloc = SessionTypeBloc();
  }

  @override
  void dispose() {
    _pointsController.dispose();
    _bloc.close();
    super.dispose();
  }

  void _onUpdatePressed() {
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

    _bloc.add(UpdateSessionTypeEvent(
      sessionTypeId: widget.sessionType.id,
      points: points,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionTypeBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: const CustomActionAppBar(title: 'Update Session Type'),
        body: BlocConsumer<SessionTypeBloc, SessionTypeState>(
          listener: (context, state) {
            if (state is SessionTypeSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ ${state.successMsg}'),
                  backgroundColor: Colors.green,
                ),
              );

              Navigator.pop(
                context,
                SessionTypeModel(
                  id: widget.sessionType.id,
                  points: int.tryParse(_pointsController.text.trim()),
                  description: widget.sessionType.description,
                  date:widget.sessionType.date,
                  type:widget.sessionType.type,
                ),
              );
            } else if (state is SessionTypeFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('❌ ${state.errMsg}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is SessionTypeLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _pointsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Points',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _onUpdatePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                      ),
                      child: const Text(
                        'Update Session Type',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
