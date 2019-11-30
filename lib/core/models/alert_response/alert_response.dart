import 'package:built_value/built_value.dart';

part 'alert_response.g.dart';

abstract class AlertResponse
    implements Built<AlertResponse, AlertResponseBuilder> {
  bool get confirmed;

  AlertResponse._();
  factory AlertResponse([void Function(AlertResponseBuilder) updates]) =
      _$AlertResponse;
}
