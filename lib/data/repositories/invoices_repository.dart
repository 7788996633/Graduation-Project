import 'package:graduation/blocs/invoices_bloc/invoices_event.dart';

import '../models/invoice_model.dart';
import '../services/invoices_service.dart';

class InvoiceRepository {
  Future<List<InvoiceModel>> getInvoices() async {
    var invoiceList = await InvoiceServices().getInvoices();
    return invoiceList
        .map(
          (e) => InvoiceModel.fromJson(e),
        )
        .toList();
  }

  Future<List<InvoiceModel>> getInvoiceByIssueId(int issueId) async {
    var invoiceList = await InvoiceServices().getInvoicesByIssueId(issueId);
    return invoiceList
        .map(
          (e) => InvoiceModel.fromJson(e),
        )
        .toList();
  }
}
