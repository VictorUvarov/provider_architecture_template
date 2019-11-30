import 'package:built_value/built_value.dart';

part 'user_location.g.dart';

/// Model that a dialog in the [DialogManager] accepts as input
abstract class UserLocation
    implements Built<UserLocation, UserLocationBuilder> {
  @nullable
  double get latitude;

  @nullable
  double get longitude;

  UserLocation._();
  factory UserLocation([void Function(UserLocationBuilder) updates]) =
      _$UserLocation;
}
