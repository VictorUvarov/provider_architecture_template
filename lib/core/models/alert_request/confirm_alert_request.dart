import 'package:built_value/built_value.dart';

import 'alert_request.dart';

part 'confirm_alert_request.g.dart';

abstract class ConfirmAlertRequest extends AlertRequest
    implements Built<ConfirmAlertRequest, ConfirmAlertRequestBuilder> {
  String get title;

  String get description;

  String get buttonTitle;

  ConfirmAlertRequest._();
  factory ConfirmAlertRequest(
          [void Function(ConfirmAlertRequestBuilder) updates]) =
      _$ConfirmAlertRequest;
}
