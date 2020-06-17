import 'package:app_settings/app_settings.dart';
import 'package:provider_start/core/services/app_settings/app_settings_service.dart';

class AppSettingsServiceImpl implements AppSettingsService {
  @override
  Future<void> openAppSettings() => AppSettings.openAppSettings();
}
