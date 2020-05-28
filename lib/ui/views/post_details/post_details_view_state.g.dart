// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_details_view_state.dart';

// **************************************************************************
// BuiltUnionGenerator
// **************************************************************************

enum _$PostDetailsViewStateType {
  loading,
  loaded,
  error,
}

abstract class _$PostDetailsViewState {
  final _$PostDetailsViewStateType _type;
  final List<Object> _values;
  _$PostDetailsViewState.loading()
      : _type = _$PostDetailsViewStateType.loading,
        _values = [];
  _$PostDetailsViewState.loaded(User user)
      : _type = _$PostDetailsViewStateType.loaded,
        assert(user != null,
            '_$PostDetailsViewState constructor argument user can not be null!'),
        _values = [user];
  _$PostDetailsViewState.error(String message)
      : _type = _$PostDetailsViewStateType.error,
        assert(message != null,
            '_$PostDetailsViewState constructor argument message can not be null!'),
        _values = [message];
  T match<T>(
      {@required T Function() loading,
      @required T Function(User) loaded,
      @required T Function(String) error}) {
    switch (_type) {
      case _$PostDetailsViewStateType.loading:
        return loading();
      case _$PostDetailsViewStateType.loaded:
        return loaded(_values[0]);
      case _$PostDetailsViewStateType.error:
        return error(_values[0]);
      default:
        throw StateError('PostDetailsViewState: Unknown type');
    }
  }

  bool get isLoading => _type == _$PostDetailsViewStateType.loading;
  bool get isLoaded => _type == _$PostDetailsViewStateType.loaded;
  bool get isError => _type == _$PostDetailsViewStateType.error;
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other is _$PostDetailsViewState) {
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
    return 'PostDetailsViewState.$variantStr($valuesStr)';
  }
}

Serializer<PostDetailsViewState> _$postDetailsViewStateSerializer =
    new _$PostDetailsViewStateSerializer();

class _$PostDetailsViewStateSerializer
    implements StructuredSerializer<PostDetailsViewState> {
  @override
  final Iterable<Type> types = const [
    PostDetailsViewState,
    _$PostDetailsViewState
  ];
  @override
  final String wireName = 'PostDetailsViewState';
  @override
  Iterable<Object> serialize(
      Serializers serializers, PostDetailsViewState object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.match(
      loading: () => <Object>['loading'],
      loaded: (user) => <Object>[
        'loaded',
        serializers.serialize(user, specifiedType: const FullType(User))
      ],
      error: (message) => <Object>[
        'error',
        serializers.serialize(message, specifiedType: const FullType(String))
      ],
    );
  }

  @override
  PostDetailsViewState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final iterator = serialized.iterator;
    iterator.moveNext();
    final key = iterator.current as String;
    var result;
    switch (key) {
      case 'loading':
        result = PostDetailsViewState.loading();
        break;
      case 'loaded':
        iterator.moveNext();
        result = PostDetailsViewState.loaded(serializers.deserialize(
            iterator.current,
            specifiedType: const FullType(User)));
        break;
      case 'error':
        iterator.moveNext();
        result = PostDetailsViewState.error(serializers.deserialize(
            iterator.current,
            specifiedType: const FullType(String)));
        break;
      default:
        throw StateError('Unknown variant $key');
    }
    return result;
  }
}
