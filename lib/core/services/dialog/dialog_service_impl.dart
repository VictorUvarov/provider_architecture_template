import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider_start/core/models/alert_request.dart';
import 'package:provider_start/core/models/alert_response.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';

/// A service that is responsible for returning future dialogs
class DialogServiceImpl implements DialogService {
  final _dialogNavigationKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  @override
  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  @override
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

  @override
  void dialogComplete(AlertResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
