// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AlertResponse extends AlertResponse {
  @override
  final bool confirmed;

  factory _$AlertResponse([void Function(AlertResponseBuilder) updates]) =>
      (new AlertResponseBuilder()..update(updates)).build();

  _$AlertResponse._({this.confirmed}) : super._() {
    if (confirmed == null) {
      throw new BuiltValueNullFieldError('AlertResponse', 'confirmed');
    }
  }

  @override
  AlertResponse rebuild(void Function(AlertResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AlertResponseBuilder toBuilder() => new AlertResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AlertResponse && confirmed == other.confirmed;
  }

  @override
  int get hashCode {
    return $jf($jc(0, confirmed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AlertResponse')
          ..add('confirmed', confirmed))
        .toString();
  }
}

class AlertResponseBuilder
    implements Builder<AlertResponse, AlertResponseBuilder> {
  _$AlertResponse _$v;

  bool _confirmed;
  bool get confirmed => _$this._confirmed;
  set confirmed(bool confirmed) => _$this._confirmed = confirmed;

  AlertResponseBuilder();

  AlertResponseBuilder get _$this {
    if (_$v != null) {
      _confirmed = _$v.confirmed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AlertResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AlertResponse;
  }

  @override
  void update(void Function(AlertResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AlertResponse build() {
    final _$result = _$v ?? new _$AlertResponse._(confirmed: confirmed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
