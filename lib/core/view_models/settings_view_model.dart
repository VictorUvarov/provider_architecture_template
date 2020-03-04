import 'package:app_settings/app_settings.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/models/alert_request/confirm_alert_request.dart';
import 'package:provider_start/core/models/alert_response/confirm_alert_response.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/snackbar/snack_bar_service.dart';
import 'package:provider_start/core/models/snack_bar_request/confirm_snack_bar_request.dart';
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

  void signOut({
    String title,
    String desc,
    String buttonConfirmText,
  }) async {
    final alertRequest = ConfirmAlertRequest(
      (r) => r
        ..title = title
        ..description = desc
        ..buttonTitle = buttonConfirmText,
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
  void showSnackbar(
      {String message, String childText, int colorCode, int duration}) async {
    final alertRequest = ConfirmSnackBarRequest((r) => r
      ..message = message
      ..childtext = childText
      ..colorCode = colorCode
      ..duration = duration);
    await _snackBarService.showSnackBar(alertRequest);
  }
}
