import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/consultations_bloc/consultation_bloc.dart';

class AddConsultationScreen extends StatefulWidget {
  final int consultationRequestId;

  const AddConsultationScreen({
    Key? key,
    required this.consultationRequestId,
  }) : super(key: key);

  @override
  State<AddConsultationScreen> createState() => _AddConsultationScreenState();
}

class _AddConsultationScreenState extends State<AddConsultationScreen> {
  final TextEditingController _resaultController = TextEditingController();
  final TextEditingController _requestIdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final resault = _resaultController.text.trim();
      final requestId = int.tryParse(_requestIdController.text.trim());

      if (requestId != null) {
        BlocProvider.of<ConsultationBloc>(context).add(
          AddConsultationEvent(
            resault: resault,
            consultationRequestId: requestId,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("رقم الطلب يجب أن يكون رقماً صحيحاً")),
        );
      }
    }
  }

  @override
  void dispose() {
    _resaultController.dispose();
    _requestIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة استشارة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ConsultationBloc, ConsultationState>(
          listener: (context, state) {
            if (state is ConsultationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.successmsg)),
              );
              _resaultController.clear();
              _requestIdController.clear();
            } else if (state is ConsultationFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('خطأ: ${state.errmsg}')),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _resaultController,
                    decoration: const InputDecoration(
                      labelText: 'نتيجة الاستشارة',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال نتيجة الاستشارة';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _requestIdController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'رقم طلب الاستشارة',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال رقم الطلب';
                      }
                      if (int.tryParse(value) == null) {
                        return 'رقم الطلب يجب أن يكون رقماً صحيحاً';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  state is ConsultationLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('إرسال'),
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
