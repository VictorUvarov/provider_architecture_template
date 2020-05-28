// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_state.dart';

// **************************************************************************
// BuiltUnionGenerator
// **************************************************************************

enum _$LoginViewStateType {
  initial,
  loading,
  error,
}

abstract class _$LoginViewState {
  final _$LoginViewStateType _type;
  final List<Object> _values;
  _$LoginViewState.initial()
      : _type = _$LoginViewStateType.initial,
        _values = [];
  _$LoginViewState.loading()
      : _type = _$LoginViewStateType.loading,
        _values = [];
  _$LoginViewState.error(String message)
      : _type = _$LoginViewStateType.error,
        assert(message != null,
            '_$LoginViewState constructor argument message can not be null!'),
        _values = [message];
  T match<T>(
      {@required T Function() initial,
      @required T Function() loading,
      @required T Function(String) error}) {
    switch (_type) {
      case _$LoginViewStateType.initial:
        return initial();
      case _$LoginViewStateType.loading:
        return loading();
      case _$LoginViewStateType.error:
        return error(_values[0]);
      default:
        throw StateError('LoginViewState: Unknown type');
    }
  }

  bool get isInitial => _type == _$LoginViewStateType.initial;
  bool get isLoading => _type == _$LoginViewStateType.loading;
  bool get isError => _type == _$LoginViewStateType.error;
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other is _$LoginViewState) {
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
    return 'LoginViewState.$variantStr($valuesStr)';
  }
}

Serializer<LoginViewState> _$loginViewStateSerializer =
    new _$LoginViewStateSerializer();

class _$LoginViewStateSerializer
    implements StructuredSerializer<LoginViewState> {
  @override
  final Iterable<Type> types = const [LoginViewState, _$LoginViewState];
  @override
  final String wireName = 'LoginViewState';
  @override
  Iterable<Object> serialize(Serializers serializers, LoginViewState object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.match(
      initial: () => <Object>['initial'],
      loading: () => <Object>['loading'],
      error: (message) => <Object>[
        'error',
        serializers.serialize(message, specifiedType: const FullType(String))
      ],
    );
  }

  @override
  LoginViewState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final iterator = serialized.iterator;
    iterator.moveNext();
    final key = iterator.current as String;
    var result;
    switch (key) {
      case 'initial':
        result = LoginViewState.initial();
        break;
      case 'loading':
        result = LoginViewState.loading();
        break;
      case 'error':
        iterator.moveNext();
        result = LoginViewState.error(serializers.deserialize(iterator.current,
            specifiedType: const FullType(String)));
        break;
      default:
        throw StateError('Unknown variant $key');
    }
    return result;
  }
}
