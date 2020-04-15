import 'package:app_settings/app_settings.dart';
import 'package:get/get.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class SettingsViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _keyStorageService = locator<KeyStorageService>();

  bool _notificationsEnabled = false;
  bool get notificationsEnabled => _notificationsEnabled;

  Future<void> init() async {
    setState(ViewState.Busy);
    _notificationsEnabled = _keyStorageService.hasNotificationsEnabled;
    setState(ViewState.Idle);
  }

  void openAppSettings() {
    Logger.d('User has opened app settings');
    AppSettings.openAppSettings();
  }

  Future<void> signOut() async {
    Logger.d('User has signed out');
    await _authService.signOut();
    await Get.offAllNamed(ViewRoutes.login);
  }

  void toggleNotificationsEnabled() {
    _notificationsEnabled = !_notificationsEnabled;
    _keyStorageService.hasNotificationsEnabled = _notificationsEnabled;
    notifyListeners();
  }
}
