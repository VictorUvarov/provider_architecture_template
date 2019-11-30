// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserLocation extends UserLocation {
  @override
  final double latitude;
  @override
  final double longitude;

  factory _$UserLocation([void Function(UserLocationBuilder) updates]) =>
      (new UserLocationBuilder()..update(updates)).build();

  _$UserLocation._({this.latitude, this.longitude}) : super._();

  @override
  UserLocation rebuild(void Function(UserLocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserLocationBuilder toBuilder() => new UserLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserLocation &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, latitude.hashCode), longitude.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserLocation')
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class UserLocationBuilder
    implements Builder<UserLocation, UserLocationBuilder> {
  _$UserLocation _$v;

  double _latitude;
  double get latitude => _$this._latitude;
  set latitude(double latitude) => _$this._latitude = latitude;

  double _longitude;
  double get longitude => _$this._longitude;
  set longitude(double longitude) => _$this._longitude = longitude;

  UserLocationBuilder();

  UserLocationBuilder get _$this {
    if (_$v != null) {
      _latitude = _$v.latitude;
      _longitude = _$v.longitude;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserLocation other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserLocation;
  }

  @override
  void update(void Function(UserLocationBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserLocation build() {
    final _$result =
        _$v ?? new _$UserLocation._(latitude: latitude, longitude: longitude);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
