import 'dart:ui';
import 'package:flutter/material.dart';

abstract class LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  final Locale locale;
  final BuildContext context;

  ChangeLocale(this.locale, this.context);
}
