import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider_start/core/models/alert_request.dart';
import 'package:provider_start/core/models/alert_response.dart';

/// A service that is responsible for returning future dialogs
class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog({
    String title,
    String description,
    String buttonTitle,
  }) {
    _dialogCompleter = Completer<AlertResponse>();

    _showDialogListener(AlertRequest(
      title: title,
      description: description,
      buttonTitle: buttonTitle,
    ));

    return _dialogCompleter.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
