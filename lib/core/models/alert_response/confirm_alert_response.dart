import 'package:built_value/built_value.dart';

import 'package:provider_start/core/models/alert_response/alert_response.dart';

part 'confirm_alert_response.g.dart';

abstract class ConfirmAlertResponse extends AlertResponse
    implements Built<ConfirmAlertResponse, ConfirmAlertResponseBuilder> {
  bool get confirmed;

  ConfirmAlertResponse._();
  factory ConfirmAlertResponse(
          [void Function(ConfirmAlertResponseBuilder) updates]) =
      _$ConfirmAlertResponse;
}
