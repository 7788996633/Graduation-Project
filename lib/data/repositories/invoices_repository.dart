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
}
