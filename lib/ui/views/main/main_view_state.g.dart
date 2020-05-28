// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_view_state.dart';

// **************************************************************************
// BuiltUnionGenerator
// **************************************************************************

enum _$MainViewStateType {
  initial,
}

abstract class _$MainViewState {
  final _$MainViewStateType _type;
  final List<Object> _values;
  _$MainViewState.initial(int index)
      : _type = _$MainViewStateType.initial,
        assert(index != null,
            '_$MainViewState constructor argument index can not be null!'),
        _values = [index];
  T match<T>({@required T Function(int) initial}) {
    switch (_type) {
      case _$MainViewStateType.initial:
        return initial(_values[0]);
      default:
        throw StateError('MainViewState: Unknown type');
    }
  }

  bool get isInitial => _type == _$MainViewStateType.initial;
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other is _$MainViewState) {
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
    return 'MainViewState.$variantStr($valuesStr)';
  }
}

Serializer<MainViewState> _$mainViewStateSerializer =
    new _$MainViewStateSerializer();

class _$MainViewStateSerializer implements StructuredSerializer<MainViewState> {
  @override
  final Iterable<Type> types = const [MainViewState, _$MainViewState];
  @override
  final String wireName = 'MainViewState';
  @override
  Iterable<Object> serialize(Serializers serializers, MainViewState object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.match(
      initial: (index) => <Object>[
        'initial',
        serializers.serialize(index, specifiedType: const FullType(int))
      ],
    );
  }

  @override
  MainViewState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final iterator = serialized.iterator;
    iterator.moveNext();
    final key = iterator.current as String;
    var result;
    switch (key) {
      case 'initial':
        iterator.moveNext();
        result = MainViewState.initial(serializers.deserialize(iterator.current,
            specifiedType: const FullType(int)));
        break;
      default:
        throw StateError('Unknown variant $key');
    }
    return result;
  }
}
