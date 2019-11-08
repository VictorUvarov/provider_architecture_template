import 'package:app_settings/app_settings.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class SettingsModel extends BaseModel {
  final _dialogService = locator<DialogService>();
  final _keyStorageService = locator<KeyStorageService>();
  final _navigationService = locator<NavigationService>();

  bool get isNightMode => _keyStorageService.nightMode;

  Future<void> init() async {
    setState(ViewState.Busy);

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
      _keyStorageService.hasLoggedIn = false;
      await _navigationService.popAllAndPushNamed(ViewRoutes.login);
    }
  }
}
