import 'dart:core';
import 'package:bloc/bloc.dart';
import '../../data/models/invoice_model.dart';
import '../../data/repositories/invoices_repository.dart';
import '../../data/services/invoices_service.dart';
import 'invoices_event.dart';
import 'invoices_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(InvoiceInitial()) {
    List<InvoiceModel> allInvoices = [];

    on<InvoiceEvent>((event, emit) async {
      if (event is AddInvoiceEvent) {
        emit(InvoiceLoading());
        try {
          String result = await InvoiceServices().addInvoice(
            event.issueId,
            event.userId,
            event.status,
            event.amount,
          );
          emit(InvoiceSuccess(successMsg: result));
        } catch (e) {
          emit(InvoiceFail(errMsg: e.toString()));
        }
      } else if (event is GetInvoiceByIdEvent) {
        emit(InvoiceLoading());
        try {
          InvoiceModel invoice =
              await InvoiceServices().getInvoiceById(event.invoiceId);
          emit(InvoiceLoaded(invoice: invoice));
        } catch (e) {
          emit(InvoiceFail(errMsg: e.toString()));
        }
      } else if (event is GetInvoiceByUserIdEvent) {
        emit(InvoiceLoading());
        try {
          InvoiceModel invoice =
              await InvoiceServices().getInvoiceById(event.userId);
          emit(InvoiceLoaded(invoice: invoice));
        } catch (e) {
          emit(InvoiceFail(errMsg: e.toString()));
        }
      } else if (event is GetInvoiceByIssueIdEvent) {
        emit(InvoiceLoading());
        try {
          List<InvoiceModel> invoices =
              await InvoiceRepository().getInvoiceByIssueId(event.issueId);
          emit(InvoiceListLoaded(list: invoices));
        } catch (e) {
          emit(InvoiceFail(errMsg: e.toString()));
        }
      } else if (event is GetAllInvoicesEvent) {
        emit(InvoiceLoading());
        try {
          allInvoices = await InvoiceRepository().getInvoices();
          emit(InvoiceListLoaded(list: allInvoices));
        } catch (e) {
          emit(InvoiceFail(errMsg: e.toString()));
        }
      } else if (event is UpdateInvoiceEvent) {
        emit(InvoiceLoading());
        try {
          String result = await InvoiceServices()
              .updateInvoice(event.invoiceId, event.status, event.amount);
          emit(InvoiceSuccess(successMsg: result));
        } catch (e) {
          emit(InvoiceFail(errMsg: e.toString()));
        }
      } else if (event is DeleteInvoiceEvent) {
        emit(InvoiceLoading());
        try {
          String result =
              await InvoiceServices().deleteInvoice(event.invoiceId);
          emit(InvoiceSuccess(successMsg: result));
        } catch (e) {
          emit(InvoiceFail(errMsg: e.toString()));
        }
      }
    });
  }
}
