import 'package:flutter/widgets.dart';

Locale loadSupportedLocals(locale, supportedLocales) {
  for (Locale supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode ||
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }

  return supportedLocales.first;
}
