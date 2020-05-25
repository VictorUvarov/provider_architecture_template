import 'package:app_settings/app_settings.dart';

import '../../../core/constant/local_keys.dart';
import '../../../core/constant/view_routes.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/models/alert_request/confirm_alert_request.dart';
import '../../../core/models/alert_response/confirm_alert_response.dart';
import '../../../core/models/snack_bar_request/confirm_snack_bar_request.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/services/dialog/dialog_service.dart';
import '../../../core/services/key_storage/key_storage_service.dart';
import '../../../core/services/navigation/navigation_service.dart';
import '../../../core/services/snackbar/snack_bar_service.dart';
import '../../../core/utils/logger.dart';
import '../../../locator.dart';
import '../../shared/base_viewmodel_extension.dart';

class SettingsViewModel extends BaseViewModelExt {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();
  final _keyStorageService = locator<KeyStorageService>();
  final _snackBarService = locator<SnackBarService>();

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
    final alertRequest = ConfirmAlertRequest(
      (r) => r
        ..title = LocalKeys.settings_view_sign_out
        ..description = LocalKeys.settings_view_sign_out_desc
        ..buttonTitle = LocalKeys.button_confirm,
    );
    final ConfirmAlertResponse dialogResult =
        await _dialogService.showDialog(alertRequest);

    if (dialogResult.confirmed) {
      Logger.d('User has signed out');
      await _authService.signOut();
      await _navigationService.popAllAndPushNamed(ViewRoutes.login);
    }
  }

  void toggleNotificationsEnabled() {
    _notificationsEnabled = !_notificationsEnabled;
    _keyStorageService.hasNotificationsEnabled = _notificationsEnabled;
    notifyListeners();
  }

  // Snack bar Sample usage
  Future<void> showSnackbar() async {
    final request = ConfirmSnackBarRequest(
      (r) => r
        ..message = LocalKeys.snackbar_message
        ..buttonText = LocalKeys.snackbar_action,
    );
    await _snackBarService.showSnackBar(request);
  }
}
