// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_alert_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConfirmAlertRequest extends ConfirmAlertRequest {
  @override
  final String title;
  @override
  final String description;
  @override
  final String buttonTitle;

  factory _$ConfirmAlertRequest(
          [void Function(ConfirmAlertRequestBuilder) updates]) =>
      (new ConfirmAlertRequestBuilder()..update(updates)).build();

  _$ConfirmAlertRequest._({this.title, this.description, this.buttonTitle})
      : super._() {
    if (title == null) {
      throw new BuiltValueNullFieldError('ConfirmAlertRequest', 'title');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ConfirmAlertRequest', 'description');
    }
    if (buttonTitle == null) {
      throw new BuiltValueNullFieldError('ConfirmAlertRequest', 'buttonTitle');
    }
  }

  @override
  ConfirmAlertRequest rebuild(
          void Function(ConfirmAlertRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConfirmAlertRequestBuilder toBuilder() =>
      new ConfirmAlertRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConfirmAlertRequest &&
        title == other.title &&
        description == other.description &&
        buttonTitle == other.buttonTitle;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, title.hashCode), description.hashCode),
        buttonTitle.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ConfirmAlertRequest')
          ..add('title', title)
          ..add('description', description)
          ..add('buttonTitle', buttonTitle))
        .toString();
  }
}

class ConfirmAlertRequestBuilder
    implements Builder<ConfirmAlertRequest, ConfirmAlertRequestBuilder> {
  _$ConfirmAlertRequest _$v;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _buttonTitle;
  String get buttonTitle => _$this._buttonTitle;
  set buttonTitle(String buttonTitle) => _$this._buttonTitle = buttonTitle;

  ConfirmAlertRequestBuilder();

  ConfirmAlertRequestBuilder get _$this {
    if (_$v != null) {
      _title = _$v.title;
      _description = _$v.description;
      _buttonTitle = _$v.buttonTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConfirmAlertRequest other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ConfirmAlertRequest;
  }

  @override
  void update(void Function(ConfirmAlertRequestBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ConfirmAlertRequest build() {
    final _$result = _$v ??
        new _$ConfirmAlertRequest._(
            title: title, description: description, buttonTitle: buttonTitle);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
