// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_snack_bar_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmSnackBarResponse extends ConfirmSnackBarResponse {
  @override
  final bool confirmed;

  factory _$ConfirmSnackBarResponse(
          [void Function(ConfirmSnackBarResponseBuilder) updates]) =>
      (new ConfirmSnackBarResponseBuilder()..update(updates)).build();

  _$ConfirmSnackBarResponse._({this.confirmed}) : super._() {
    if (confirmed == null) {
      throw new BuiltValueNullFieldError(
          'ConfirmSnackBarResponse', 'confirmed');
    }
  }

  @override
  ConfirmSnackBarResponse rebuild(
          void Function(ConfirmSnackBarResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfirmSnackBarResponseBuilder toBuilder() =>
      new ConfirmSnackBarResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmSnackBarResponse && confirmed == other.confirmed;
  }

  @override
  int get hashCode {
    return $jf($jc(0, confirmed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConfirmSnackBarResponse')
          ..add('confirmed', confirmed))
        .toString();
  }
}

class ConfirmSnackBarResponseBuilder
    implements
        Builder<ConfirmSnackBarResponse, ConfirmSnackBarResponseBuilder> {
  _$ConfirmSnackBarResponse _$v;

  bool _confirmed;
  bool get confirmed => _$this._confirmed;
  set confirmed(bool confirmed) => _$this._confirmed = confirmed;

  ConfirmSnackBarResponseBuilder();

  ConfirmSnackBarResponseBuilder get _$this {
    if (_$v != null) {
      _confirmed = _$v.confirmed;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmSnackBarResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ConfirmSnackBarResponse;
  }

  @override
  void update(void Function(ConfirmSnackBarResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ConfirmSnackBarResponse build() {
    final _$result =
        _$v ?? new _$ConfirmSnackBarResponse._(confirmed: confirmed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
