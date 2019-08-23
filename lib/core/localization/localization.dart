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
      'settings-view-alert': 'Show Alert',
      'settings-view-alert-desc': 'This shows a dialog',
      'settings-view-night-mode': 'Night Mode',
      'settings-view-night-mode-desc': 'Change to dark theme',
      'login-view-title': 'Login',
      'login-button-text': 'Login',
      'button-text-cancel': 'Cancel',
      'button-text-confirm': 'Confirm',
      'dialog-title': 'Title',
      'dialog-desc': 'This is the description.'
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
  String get settingsViewAlert =>
      _localizedValues[locale.languageCode]['settings-view-alert'];
  String get settingsViewAlertDesc =>
      _localizedValues[locale.languageCode]['settings-view-alert-desc'];
  String get settingsViewNightMode =>
      _localizedValues[locale.languageCode]['settings-view-night-mode'];
  String get settingsViewNightModeDesc =>
      _localizedValues[locale.languageCode]['settings-view-night-mode-desc'];
  String get loginViewTitle =>
      _localizedValues[locale.languageCode]['login-view-title'];
  String get loginButtonText =>
      _localizedValues[locale.languageCode]['login-button-text'];
  String get buttonTextCancel =>
      _localizedValues[locale.languageCode]['button-text-cancel'];
  String get buttonTextConfirm =>
      _localizedValues[locale.languageCode]['button-text-confirm'];
  String get dialogTitle =>
      _localizedValues[locale.languageCode]['dialog-title'];
  String get dialogDesc => _localizedValues[locale.languageCode]['dialog-desc'];
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
