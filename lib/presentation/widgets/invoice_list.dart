import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../blocs/invoices_bloc/invoices_event.dart';
import '../../blocs/invoices_bloc/invoices_state.dart';
import '../../data/models/invoice_model.dart';
import 'invoice_item.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key, required this.bloc, required this.issueId});
  final InvoiceBloc bloc;
  final int issueId;

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  List<InvoiceModel> invoiceList = [];

  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetInvoiceByIssueIdEvent(issueId: widget.issueId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceBloc, InvoiceState>(
      listener: (context, state) {
        if (state is InvoiceSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetInvoiceByIssueIdEvent(issueId: widget.issueId));
        } else if (state is InvoiceFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceListLoaded) {
            invoiceList = state.list;
            if (invoiceList.isEmpty) {
              return const Center(
                child: Text(
                  'There are no invoices',
                ),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: invoiceList.length,
                itemBuilder: (context, index) {
                  return InvoiceItem(
                    invoiceModel: invoiceList[index],
                  );
                },
              );
            }
          } else if (state is InvoiceFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errMsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
