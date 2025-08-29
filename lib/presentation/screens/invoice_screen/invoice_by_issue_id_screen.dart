import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_event.dart';
import '../../../constant.dart';
import '../../../responsive.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/invoice_list.dart';
import '../../widgets/refresh_button.dart';
import 'add_invoice_screen.dart';

class ListInvoicesByIssueScreen extends StatefulWidget {
  final int issueId;
  final int userId;
  const ListInvoicesByIssueScreen(
      {super.key, required this.issueId, required this.userId});

  @override
  State<ListInvoicesByIssueScreen> createState() =>
      _ListInvoicesByIssueScreenState();
}

class _ListInvoicesByIssueScreenState extends State<ListInvoicesByIssueScreen> {
  late InvoiceBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<InvoiceBloc>(context);
    bloc.add(GetInvoiceByIssueIdEvent(
        issueId: widget.issueId)); // استدعاء حدث حسب الـ issueId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            InvoiceList(
              bloc: bloc,
              issueId: widget.issueId,
            ),
            if (myRole == 'admin')
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => InvoiceBloc(),
                        child: AddInvoiceScreen(
                          issueId: widget.issueId,
                          userId: widget.userId,
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  "Add Invoices",
                  style: TextStyle(
                      fontSize: s18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(
            GetInvoiceByIssueIdEvent(
              issueId: widget.issueId,
            ),
          );
        },
      ),
    );
  }
}
