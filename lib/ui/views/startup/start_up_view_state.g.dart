// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_up_view_state.dart';

// **************************************************************************
// BuiltUnionGenerator
// **************************************************************************

enum _$StartupViewStateType {
  loading,
}

abstract class _$StartupViewState {
  final _$StartupViewStateType _type;
  final List<Object> _values;
  _$StartupViewState.loading()
      : _type = _$StartupViewStateType.loading,
        _values = [];
  T match<T>({@required T Function() loading}) {
    switch (_type) {
      case _$StartupViewStateType.loading:
        return loading();
      default:
        throw StateError('StartupViewState: Unknown type');
    }
  }

  bool get isLoading => _type == _$StartupViewStateType.loading;
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other is _$StartupViewState) {
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
    return 'StartupViewState.$variantStr($valuesStr)';
  }
}

Serializer<StartupViewState> _$startupViewStateSerializer =
    new _$StartupViewStateSerializer();

class _$StartupViewStateSerializer
    implements StructuredSerializer<StartupViewState> {
  @override
  final Iterable<Type> types = const [StartupViewState, _$StartupViewState];
  @override
  final String wireName = 'StartupViewState';
  @override
  Iterable<Object> serialize(Serializers serializers, StartupViewState object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.match(
      loading: () => <Object>['loading'],
    );
  }

  @override
  StartupViewState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final iterator = serialized.iterator;
    iterator.moveNext();
    final key = iterator.current as String;
    var result;
    switch (key) {
      case 'loading':
        result = StartupViewState.loading();
        break;
      default:
        throw StateError('Unknown variant $key');
    }
    return result;
  }
}
