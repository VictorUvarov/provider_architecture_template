import 'package:built_value/built_value.dart';
import 'package:provider_start/core/models/alert_response/alert_response.dart';

part 'confirm_snack_bar_response.g.dart';

abstract class ConfirmSnackBarResponse extends AlertResponse
    implements Built<ConfirmSnackBarResponse, ConfirmSnackBarResponseBuilder> {
  bool get confirmed;

  ConfirmSnackBarResponse._();
  factory ConfirmSnackBarResponse(
          [void Function(ConfirmSnackBarResponseBuilder) updates]) =
      _$ConfirmSnackBarResponse;
}
