// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_snack_bar_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmSnackBarRequest extends ConfirmSnackBarRequest {
  @override
  final String message;
  @override
  final String childtext;

  factory _$ConfirmSnackBarRequest(
          [void Function(ConfirmSnackBarRequestBuilder) updates]) =>
      (new ConfirmSnackBarRequestBuilder()..update(updates)).build();

  _$ConfirmSnackBarRequest._({this.message, this.childtext}) : super._() {
    if (message == null) {
      throw new BuiltValueNullFieldError('ConfirmSnackBarRequest', 'message');
    }
    if (childtext == null) {
      throw new BuiltValueNullFieldError('ConfirmSnackBarRequest', 'childtext');
    }
  }

  @override
  ConfirmSnackBarRequest rebuild(
          void Function(ConfirmSnackBarRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfirmSnackBarRequestBuilder toBuilder() =>
      new ConfirmSnackBarRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmSnackBarRequest &&
        message == other.message &&
        childtext == other.childtext;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, message.hashCode), childtext.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConfirmSnackBarRequest')
          ..add('message', message)
          ..add('childtext', childtext))
        .toString();
  }
}

class ConfirmSnackBarRequestBuilder
    implements Builder<ConfirmSnackBarRequest, ConfirmSnackBarRequestBuilder> {
  _$ConfirmSnackBarRequest _$v;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _childtext;
  String get childtext => _$this._childtext;
  set childtext(String childtext) => _$this._childtext = childtext;

  ConfirmSnackBarRequestBuilder();

  ConfirmSnackBarRequestBuilder get _$this {
    if (_$v != null) {
      _message = _$v.message;
      _childtext = _$v.childtext;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmSnackBarRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ConfirmSnackBarRequest;
  }

  @override
  void update(void Function(ConfirmSnackBarRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ConfirmSnackBarRequest build() {
    final _$result = _$v ??
        new _$ConfirmSnackBarRequest._(message: message, childtext: childtext);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
