import 'package:flutter/widgets.dart';
import 'package:provider_start/core/models/alert_request/alert_request.dart';
import 'package:provider_start/core/models/alert_response/alert_response.dart';

abstract class DialogService {
  GlobalKey<NavigatorState> get dialogNavigationKey;

  void registerDialogListener(Function(AlertRequest) showDialogListener);

  Future<AlertResponse> showDialog(AlertRequest alertRequest);

  void dialogComplete(AlertResponse response);
}
