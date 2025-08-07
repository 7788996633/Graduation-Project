
import 'package:flutter/cupertino.dart';
import '../../data/models/invoice_model.dart';

@immutable
sealed class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}

final class InvoiceLoading extends InvoiceState {}

final class InvoiceSuccess extends InvoiceState {
  final String successMsg;

  InvoiceSuccess({required this.successMsg});
}

final class InvoiceLoaded extends InvoiceState {
  final InvoiceModel invoice;

  InvoiceLoaded({required this.invoice});
}

final class InvoiceListLoaded extends InvoiceState {
  final List<InvoiceModel> list;

  InvoiceListLoaded({required this.list});
}

final class InvoiceFail extends InvoiceState {
  final String errMsg;

  InvoiceFail({required this.errMsg});
}
