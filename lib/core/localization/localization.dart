import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:provider_start/local_setup.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _sentences;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  Future<bool> load() async {
    final path = 'assets/lang/${locale.languageCode}.json';
    final data = await rootBundle.loadString(path);
    final Map<String, dynamic> _result = json.decode(data);

    _sentences = <String, String>{};
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String translate(String key) {
    return _sentences[key];
  }

  // List of available local strings that the app can use
  //  - translated from the corresponding /assets/lang/<local>.json files
  String get appTitle => translate('app-title');

  String get homeViewTitle => translate('home-view-title');
  String get homeViewNoPosts => translate('home-view-no-posts');

  String get settingsViewTitle => translate('settings-view-title');
  String get settingsViewPermissions => translate('settings-view-permissions');
  String get settingsViewPermissionsDesc =>
      translate('settings-view-permissions-desc');
  String get settingsViewAppSettings => translate('settings-view-app-settings');
  String get settingsViewAppSettingsDesc =>
      translate('settings-view-app-settings-desc');
  String get settingsViewNotifications =>
      translate('settings-view-notifications');
  String get settingsViewNotificationsDesc =>
      translate('settings-view-notifications-desc');
  String get settingsViewLocation => translate('settings-view-location');
  String get settingsViewSignOut => translate('settings-view-sign-out');
  String get settingsViewSignOutDesc =>
      translate('settings-view-sign-out-desc');

  String get loginViewTitle => translate('login-view-title');
  String get loginButtonText => translate('login-button-text');

  String get buttonTextCancel => translate('button-text-cancel');
  String get buttonTextConfirm => translate('button-text-confirm');

  String get emailHintText => translate('email-hint-text');
  String get passwordHintText => translate('password-hint-text');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLocalCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLocalCodes.contains(locale.languageCode);
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(locale);
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}
