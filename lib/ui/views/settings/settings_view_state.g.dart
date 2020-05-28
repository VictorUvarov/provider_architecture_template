// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_view_state.dart';

// **************************************************************************
// BuiltUnionGenerator
// **************************************************************************

enum _$SettingsViewStateType {
  loading,
  loaded,
  error,
}

abstract class _$SettingsViewState {
  final _$SettingsViewStateType _type;
  final List<Object> _values;
  _$SettingsViewState.loading()
      : _type = _$SettingsViewStateType.loading,
        _values = [];
  _$SettingsViewState.loaded(bool notificationsEnabled)
      : _type = _$SettingsViewStateType.loaded,
        assert(notificationsEnabled != null,
            '_$SettingsViewState constructor argument notificationsEnabled can not be null!'),
        _values = [notificationsEnabled];
  _$SettingsViewState.error(String message)
      : _type = _$SettingsViewStateType.error,
        assert(message != null,
            '_$SettingsViewState constructor argument message can not be null!'),
        _values = [message];
  T match<T>(
      {@required T Function() loading,
      @required T Function(bool) loaded,
      @required T Function(String) error}) {
    switch (_type) {
      case _$SettingsViewStateType.loading:
        return loading();
      case _$SettingsViewStateType.loaded:
        return loaded(_values[0]);
      case _$SettingsViewStateType.error:
        return error(_values[0]);
      default:
        throw StateError('SettingsViewState: Unknown type');
    }
  }

  bool get isLoading => _type == _$SettingsViewStateType.loading;
  bool get isLoaded => _type == _$SettingsViewStateType.loaded;
  bool get isError => _type == _$SettingsViewStateType.error;
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other is _$SettingsViewState) {
      if (_type != other._type) {
        return false;
      }
      if (_values.length != other._values.length) {
        return false;
      }
      for (var i = 0; i < _values.length; ++i) {
        if (_values[i] != other._values[i]) {
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    var curVal = $jc(0, _type.hashCode);
    for (final value in _values) {
      curVal = $jc(curVal, value.hashCode);
    }

    return $jf(curVal);
  }

  @override
  toString() {
    final variantStr = '$_type'.split('.')[1];
    final valuesStr = _values.map((value) => '$value').join(', ');
    return 'SettingsViewState.$variantStr($valuesStr)';
  }
}

Serializer<SettingsViewState> _$settingsViewStateSerializer =
    new _$SettingsViewStateSerializer();

class _$SettingsViewStateSerializer
    implements StructuredSerializer<SettingsViewState> {
  @override
  final Iterable<Type> types = const [SettingsViewState, _$SettingsViewState];
  @override
  final String wireName = 'SettingsViewState';
  @override
  Iterable<Object> serialize(Serializers serializers, SettingsViewState object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.match(
      loading: () => <Object>['loading'],
      loaded: (notificationsEnabled) => <Object>[
        'loaded',
        serializers.serialize(notificationsEnabled,
            specifiedType: const FullType(bool))
      ],
      error: (message) => <Object>[
        'error',
        serializers.serialize(message, specifiedType: const FullType(String))
      ],
    );
  }

  @override
  SettingsViewState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final iterator = serialized.iterator;
    iterator.moveNext();
    final key = iterator.current as String;
    var result;
    switch (key) {
      case 'loading':
        result = SettingsViewState.loading();
        break;
      case 'loaded':
        iterator.moveNext();
        result = SettingsViewState.loaded(serializers.deserialize(
            iterator.current,
            specifiedType: const FullType(bool)));
        break;
      case 'error':
        iterator.moveNext();
        result = SettingsViewState.error(serializers.deserialize(
            iterator.current,
            specifiedType: const FullType(String)));
        break;
      default:
        throw StateError('Unknown variant $key');
    }
    return result;
  }
}
