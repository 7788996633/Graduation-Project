import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'locale_event.dart';
import 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(Locale('en'))) {
    on<ChangeLocale>((event, emit) async {
      // تغيير اللغة فعلياً عبر EasyLocalization باستخدام السياق الممرر
      await EasyLocalization.of(event.context)?.setLocale(event.locale);
      // تحديث حالة البلوك مع اللغة الجديدة
      emit(LocaleState(event.locale));
    });
  }
}
