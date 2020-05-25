import 'dart:async';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';

import '../../../locator.dart';
import '../../../ui/widgets/dialogs/confirm_dialog.dart';
import '../../localization/localization.dart';
import '../../models/alert_request/alert_request.dart';
import '../../models/alert_request/confirm_alert_request.dart';
import '../../models/alert_response/alert_response.dart';
import '../../models/alert_response/confirm_alert_response.dart';
import '../navigation/navigation_service.dart';
import 'dialog_service.dart';

/// A service that is responsible for returning future dialogs
class DialogServiceImpl implements DialogService {
  Completer<AlertResponse> _dialogCompleter;

  @override
  Future<AlertResponse> showDialog(AlertRequest request) {
    _dialogCompleter = Completer<AlertResponse>();

    if (request is ConfirmAlertRequest) {
      _showConfirmAlert(request);
    }

    return _dialogCompleter.future;
  }

  @override
  void completeDialog(AlertResponse response) {
    locator<NavigationService>().pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }

  void _showConfirmAlert(ConfirmAlertRequest request) {
    final local = AppLocalizations.of(Get.overlayContext);

    showPlatformDialog(
      context: Get.overlayContext,
      builder: (context) => ConfirmDialog(
        title: local.translate(request.title),
        description: local.translate(request.description),
        buttonTitle: local.translate(request.buttonTitle),
        onConfirmed: () {
          if (!_dialogCompleter.isCompleted) {
            completeDialog(ConfirmAlertResponse((a) => a..confirmed = true));
          }
        },
        onDenied: () {
          if (!_dialogCompleter.isCompleted) {
            completeDialog(ConfirmAlertResponse((a) => a..confirmed = false));
          }
        },
      ),
    );
  }
}
