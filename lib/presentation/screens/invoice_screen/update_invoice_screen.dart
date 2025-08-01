import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_event.dart';
import '../../../blocs/invoices_bloc/invoices_state.dart';
import '../../../data/models/invoice_model.dart';

class UpdateInvoiceScreen extends StatefulWidget {
  final InvoiceModel invoice;

  const UpdateInvoiceScreen({super.key, required this.invoice});

  @override
  State<UpdateInvoiceScreen> createState() => _UpdateInvoiceScreenState();
}

class _UpdateInvoiceScreenState extends State<UpdateInvoiceScreen> {
  final List<String> statusOptions = ['pending', 'approved', 'paid','on_hold'];//pending,approved,paid,rejected,on_hold
  late TextEditingController _amountController;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.invoice.amount?.toString() ?? '',
    );
    selectedStatus = widget.invoice.status ?? statusOptions.first;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InvoiceBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Invoice'),
          backgroundColor: Colors.brown,
        ),
        body: BlocConsumer<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('✅ ${state.successMsg}')),
              );
              Navigator.pop(context); // Go back after successful update
            } else if (state is InvoiceFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('❌ ${state.errMsg}')),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Invoice ID: ${widget.invoice.id}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text(
                    'Current Status: ${widget.invoice.status ?? '---'}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Invoice Amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                    decoration: const InputDecoration(
                      labelText: 'Select Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  state is InvoiceLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () {
                      final int? parsedAmount =
                      int.tryParse(_amountController.text.trim());
                      if (parsedAmount != null && selectedStatus != null) {
                        BlocProvider.of<InvoiceBloc>(context).add(
                          UpdateInvoiceEvent(
                            invoiceId: widget.invoice.id,
                            amount: parsedAmount,
                            status: selectedStatus!,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid amount and select a status'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                    ),
                    child: const Text(
                      'Update Invoice',
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