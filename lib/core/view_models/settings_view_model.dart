import 'package:app_settings/app_settings.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class SettingsViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _keyStorageService = locator<KeyStorageService>();

  bool _notificationsEnabled = false;
  bool get notificationsEnabled => _notificationsEnabled;

  Future<void> init() async {
    setState(ViewState.Busy);
    _notificationsEnabled = _keyStorageService.hasNotificationsEnabled;
    setState(ViewState.Idle);
  }

  Future<void> showAlert({
    String title,
    String desc,
    String buttonConfirmText,
  }) async {
    final dialogResult = await _dialogService.showDialog(
      title: title,
      description: desc,
      buttonTitle: buttonConfirmText,
    );

    if (dialogResult.confirmed) {}
  }

  void openAppSettings() {
    Logger.d('User has opened app settings');
    AppSettings.openAppSettings();
  }

  void signOut({
    String title,
    String desc,
    String buttonConfirmText,
  }) async {
    final dialogResult = await _dialogService.showDialog(
      title: title,
      description: desc,
      buttonTitle: buttonConfirmText,
    );

    if (dialogResult.confirmed) {
      Logger.d('User has signed out');
      await _authService.signOut();
      await _navigationService.popAllAndPushNamed(ViewRoutes.login);
    }
  }

  void toggleNotificationsEnabled(bool value) {
    _notificationsEnabled = value;
    _keyStorageService.hasNotificationsEnabled = value;
    notifyListeners();
  }
}
