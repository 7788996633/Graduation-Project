import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_event.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/invoice_list.dart';
import '../../widgets/refresh_button.dart';

class ListInvoicesByIdScreen extends StatefulWidget {
  final int userId;

  const ListInvoicesByIdScreen({super.key, required this.userId});

  @override
  State<ListInvoicesByIdScreen> createState() => _ListInvoicesByIdScreenState();
}

class _ListInvoicesByIdScreenState extends State<ListInvoicesByIdScreen> {
  late InvoiceBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<InvoiceBloc>(context);

    bloc.add(GetInvoiceByUserIdEvent(userId: widget.userId));
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
          bloc.add(GetInvoiceByUserIdEvent(userId: widget.userId));
        },
      ),
    );
  }
}