import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/invoice_list.dart';
import '../../widgets/refresh_button.dart';

class ListInvoicesByIssueScreen extends StatefulWidget {
  final int issueId;
  const ListInvoicesByIssueScreen({super.key, required this.issueId});

  @override
  State<ListInvoicesByIssueScreen> createState() => _ListInvoicesByIssueScreenState();
}

class _ListInvoicesByIssueScreenState extends State<ListInvoicesByIssueScreen> {
  late InvoiceBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<InvoiceBloc>(context);
    bloc.add(GetInvoiceByIssueIdEvent(issueId: widget.issueId)); // استدعاء حدث حسب الـ issueId
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Invoices',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            InvoiceList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetInvoiceByIssueIdEvent(issueId: widget.issueId)); // تحديث القائمة بنفس الـ issueId
        },
      ),
    );
  }
}
