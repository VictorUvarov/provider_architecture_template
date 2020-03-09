// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_snack_bar_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmSnackBarRequest extends ConfirmSnackBarRequest {
  @override
  final String message;
  @override
  final String buttonText;
  @override
  final void Function() onPressed;

  factory _$ConfirmSnackBarRequest(
          [void Function(ConfirmSnackBarRequestBuilder) updates]) =>
      (new ConfirmSnackBarRequestBuilder()..update(updates)).build();

  _$ConfirmSnackBarRequest._({this.message, this.buttonText, this.onPressed})
      : super._() {
    if (message == null) {
      throw new BuiltValueNullFieldError('ConfirmSnackBarRequest', 'message');
    }
    if (buttonText == null) {
      throw new BuiltValueNullFieldError(
          'ConfirmSnackBarRequest', 'buttonText');
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
    final dynamic _$dynamicOther = other;
    return other is ConfirmSnackBarRequest &&
        message == other.message &&
        buttonText == other.buttonText &&
        onPressed == _$dynamicOther.onPressed;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, message.hashCode), buttonText.hashCode),
        onPressed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConfirmSnackBarRequest')
          ..add('message', message)
          ..add('buttonText', buttonText)
          ..add('onPressed', onPressed))
        .toString();
  }
}

class ConfirmSnackBarRequestBuilder
    implements Builder<ConfirmSnackBarRequest, ConfirmSnackBarRequestBuilder> {
  _$ConfirmSnackBarRequest _$v;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _buttonText;
  String get buttonText => _$this._buttonText;
  set buttonText(String buttonText) => _$this._buttonText = buttonText;

  void Function() _onPressed;
  void Function() get onPressed => _$this._onPressed;
  set onPressed(void Function() onPressed) => _$this._onPressed = onPressed;

  ConfirmSnackBarRequestBuilder();

  ConfirmSnackBarRequestBuilder get _$this {
    if (_$v != null) {
      _message = _$v.message;
      _buttonText = _$v.buttonText;
      _onPressed = _$v.onPressed;
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
        new _$ConfirmSnackBarRequest._(
            message: message, buttonText: buttonText, onPressed: onPressed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
