import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../blocs/invoices_bloc/invoices_event.dart';
import '../../constant.dart';
import '../../data/models/invoice_model.dart';
import '../../themes.dart';

import '../screens/invoice_screen/invoice_details_screen.dart';

class InvoiceItem extends StatelessWidget {
  const InvoiceItem({super.key, required this.invoiceModel});
  final InvoiceModel invoiceModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.grey.shade400,
            width: 2,
          ),
        ),
        shadowColor: AppColors.darkBlue.withOpacity(0.4),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => InvoiceBloc(),
                  child: InvoiceDetailsScreen(
                    invoiceModel: invoiceModel,
                  ),
                ),
              ),
            );
          },
          leading: Container(
            decoration: BoxDecoration(
              color: AppColors.darkBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                BlocProvider.of<InvoiceBloc>(context).add(
                  DeleteInvoiceEvent(invoiceId: invoiceModel.id),
                );
              },
              icon: Icon(
                Icons.delete_forever,
                color: AppColors.darkBlue,
                size: 28,
              ),
              tooltip: 'Delete Invoice',
            ),
          ),
          title: Text(
            invoiceModel.status,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.darkBlue,
              letterSpacing: 0.5,
            ),
          ),
          subtitle: Text(
            'Amount: ${invoiceModel.amount}',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.darkBlue.withOpacity(0.6),
            ),
          ),
          trailing: myRole == 'admin'
              ? Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.darkBlue.withOpacity(0.7),
                  size: 32,
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
