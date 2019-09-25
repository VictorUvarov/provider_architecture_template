import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

/// Custom Localizations that [MaterialApp] accepts in `localizationsDelegates` field
class AppLocalizations {
  final Locale locale;
  Map<String, String> _sentences;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  Future<bool> load() async {
    final path = 'assets/lang/${this.locale.languageCode}.json';
    final data = await rootBundle.loadString(path);
    Map<String, dynamic> _result = json.decode(data);

    this._sentences = Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });

    return true;
  }

  String _translate(String key) {
    return this._sentences[key];
  }

  // List of available sentences that correspond to the /assets/lang/... .json files
  String get appTitle => _translate('app-title');
  String get homeViewTitle => _translate('home-view-title');
  String get settingsViewTitle => _translate('settings-view-title');
  String get settingsViewPermissions => _translate('settings-view-permissions');
  String get settingsViewPermissionsDesc =>
      _translate('settings-view-permissions-desc');
  String get settingsViewAlert => _translate('settings-view-alert');
  String get settingsViewAlertDesc => _translate('settings-view-alert-desc');
  String get settingsViewNightMode => _translate('settings-view-night-mode');
  String get settingsViewNightModeDesc =>
      _translate('settings-view-night-mode-desc');
  String get settingsViewAppSettings =>
      _translate('settings-view-app-settings');
  String get settingsViewAppSettingsDesc =>
      _translate('settings-view-app-settings-desc');
  String get loginViewTitle => _translate('login-view-title');
  String get loginButtonText => _translate('login-button-text');
  String get buttonTextCancel => _translate('button-text-cancel');
  String get buttonTextConfirm => _translate('button-text-confirm');
  String get dialogTitle => _translate('dialog-title');
  String get dialogDesc => _translate('dialog-desc');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
