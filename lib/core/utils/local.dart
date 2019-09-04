import 'package:flutter/widgets.dart';

/// A callback provided by [MaterialApp] that lets you
/// specify which locales you plan to support by returning them.
Locale loadSupportedLocals(locale, supportedLocales) {
  for (Locale supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode ||
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }

  return supportedLocales.first;
}
