import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/services/dialog_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class SettingsModel extends BaseModel {
  final _dialogService = locator<DialogService>();

  Future<void> init() async {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }

  void launchAppPermissions() {}

  Future<bool> deleteSomething() async {
    bool success = false;

    final dialogResult = await _dialogService.showDialog(
      title: 'Delete Something',
      description: 'Are you sure you want to delete this',
      buttonTitle: 'Yes delete this',
    );

    print('dialogResult: $dialogResult');

    if (dialogResult.confirmed) {
      success = true;
    }

    return success;
  }
}
