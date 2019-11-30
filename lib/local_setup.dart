import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider_start/core/localization/localization.dart';

/// List of languages codes that the app will support
/// https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
const supportedLocales = [
  Locale('en'),
  Locale('es'),
  Locale('ru'),
];

const supportedLocalCodes = ['en', 'es', 'ru'];

/// A callback provided by [MaterialApp] that lets you
/// specify which locales you plan to support by returning them.
Locale loadSupportedLocals(locale, supportedLocales) {
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode ||
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }

  return supportedLocales.first;
}

/// Internationalized apps that require translations for one of the
/// locales listed in [GlobalMaterialLocalizations] should specify
/// this parameter and list the [supportedLocales] that the
/// application can handle.
List<LocalizationsDelegate> get localizationsDelegates {
  return [
    const AppLocalizationsDelegate(),
    const FallbackCupertinoLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
