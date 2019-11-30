import 'package:built_value/built_value.dart';

part 'alert_request.g.dart';

/// Model that a dialog in the [DialogManager] accepts as input
abstract class AlertRequest
    implements Built<AlertRequest, AlertRequestBuilder> {
  String get title;

  String get description;

  String get buttonTitle;

  AlertRequest._();
  factory AlertRequest([void Function(AlertRequestBuilder) updates]) =
      _$AlertRequest;
}
