import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_event.dart';
import '../../../blocs/invoices_bloc/invoices_state.dart';
import '../../../themes.dart';
import '../../widgets/build_custom_appbar_detials.dart';
import '../../widgets/custom_text_field_add.dart';
import '../../widgets/elevated_button_submit.dart';

class AddInvoiceScreen extends StatefulWidget {
  final int issueId;
  final int userId;
  const  AddInvoiceScreen({super.key,required this.issueId,required this.userId});

  @override
  State<AddInvoiceScreen> createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {

  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.darkBlue,
      appBar: buildCustomAppBar("Add Invoice"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<InvoiceBloc, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceSuccess) {
              _statusController.clear();
              _amountController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Success: ${state.successMsg}"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is InvoiceFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed: ${state.errMsg}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create New Invoice",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _statusController,
                      label: 'Status',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldAdd(
                      controller: _amountController,
                      label: 'Amount',
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 30),
                    state is InvoiceLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 50,
                      child: CustomElevatedButtonSubmit(
                        label: "Submit",
                        onPressed: () {
                          BlocProvider.of<InvoiceBloc>(context).add(
                            AddInvoiceEvent(
                             issueId:widget.issueId,
                              userId: widget.userId,
                              status: _statusController.text.trim(),
                              amount: int.tryParse(_amountController.text.trim()) ?? 0,
                            ),
                          );
                        },
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
