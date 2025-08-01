import 'package:meta/meta.dart';

@immutable
sealed class InvoiceEvent {}

class AddInvoiceEvent extends InvoiceEvent {
  final int issueId;
  final int userId;
  final String status;
  final int amount;

  AddInvoiceEvent({
    required this.issueId,
    required this.userId,
    required this.status,
    required this.amount,
  });
}

class GetInvoiceByUserIdEvent extends InvoiceEvent {
  final int userId;
  GetInvoiceByUserIdEvent({required this.userId});
}

class GetInvoiceByIssueIdEvent extends InvoiceEvent {
  final int issueId;
  GetInvoiceByIssueIdEvent({required this.issueId});
}

class GetInvoiceByIdEvent extends InvoiceEvent {
  final int invoiceId;
  GetInvoiceByIdEvent({required this.invoiceId});
}

class GetAllInvoicesEvent extends InvoiceEvent {}

class UpdateInvoiceEvent extends InvoiceEvent {
  final int invoiceId;
  final String status ;
  final int amount ;
  UpdateInvoiceEvent({
    required this.invoiceId,
    required this.status,
    required this.amount,
  });
}

class DeleteInvoiceEvent extends InvoiceEvent {
  final int invoiceId;
  DeleteInvoiceEvent({
    required this.invoiceId,
  });
}
