import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const _localizedValues = {
    'en': {
      'app-title': 'Title',
      'home-view-title': 'Home',
      'settings-view-title': 'Settings',
      'settings-view-permissions': 'Permissions',
      'settings-view-permissions-desc': 'Open App Permissions',
      'settings-view-delete': 'Delete Something',
      'settings-view-delete-desc': 'Delete all the things',
      'login-view-title': 'Login',
      'login-button-text': 'Login',
    },
  };

  String get appTitle => _localizedValues[locale.languageCode]['app-title'];
  String get homeViewTitle =>
      _localizedValues[locale.languageCode]['home-view-title'];
  String get settingsViewTitle =>
      _localizedValues[locale.languageCode]['settings-view-title'];
  String get settingsViewPermissions =>
      _localizedValues[locale.languageCode]['settings-view-permissions'];
  String get settingsViewPermissionsDesc =>
      _localizedValues[locale.languageCode]['settings-view-permissions-desc'];
  String get settingsViewDelete =>
      _localizedValues[locale.languageCode]['settings-view-delete'];
  String get settingsViewDeleteDesc =>
      _localizedValues[locale.languageCode]['settings-view-delete-desc'];
  String get loginViewTitle =>
      _localizedValues[locale.languageCode]['login-view-title'];
  String get loginButtonText =>
      _localizedValues[locale.languageCode]['login-button-text'];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
