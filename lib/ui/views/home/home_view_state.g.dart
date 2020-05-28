// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_state.dart';

// **************************************************************************
// BuiltUnionGenerator
// **************************************************************************

enum _$HomeViewStateType {
  loading,
  noPosts,
  error,
  loaded,
}

abstract class _$HomeViewState {
  final _$HomeViewStateType _type;
  final List<Object> _values;
  _$HomeViewState.loading()
      : _type = _$HomeViewStateType.loading,
        _values = [];
  _$HomeViewState.noPosts()
      : _type = _$HomeViewStateType.noPosts,
        _values = [];
  _$HomeViewState.error(String message)
      : _type = _$HomeViewStateType.error,
        assert(message != null,
            '_$HomeViewState constructor argument message can not be null!'),
        _values = [message];
  _$HomeViewState.loaded(List<Post> posts)
      : _type = _$HomeViewStateType.loaded,
        assert(posts != null,
            '_$HomeViewState constructor argument posts can not be null!'),
        _values = [posts];
  T match<T>(
      {@required T Function() loading,
      @required T Function() noPosts,
      @required T Function(String) error,
      @required T Function(List<Post>) loaded}) {
    switch (_type) {
      case _$HomeViewStateType.loading:
        return loading();
      case _$HomeViewStateType.noPosts:
        return noPosts();
      case _$HomeViewStateType.error:
        return error(_values[0]);
      case _$HomeViewStateType.loaded:
        return loaded(_values[0]);
      default:
        throw StateError('HomeViewState: Unknown type');
    }
  }

  bool get isLoading => _type == _$HomeViewStateType.loading;
  bool get isNoPosts => _type == _$HomeViewStateType.noPosts;
  bool get isError => _type == _$HomeViewStateType.error;
  bool get isLoaded => _type == _$HomeViewStateType.loaded;
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other is _$HomeViewState) {
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
    return 'HomeViewState.$variantStr($valuesStr)';
  }
}

Serializer<HomeViewState> _$homeViewStateSerializer =
    new _$HomeViewStateSerializer();

class _$HomeViewStateSerializer implements StructuredSerializer<HomeViewState> {
  @override
  final Iterable<Type> types = const [HomeViewState, _$HomeViewState];
  @override
  final String wireName = 'HomeViewState';
  @override
  Iterable<Object> serialize(Serializers serializers, HomeViewState object,
      {FullType specifiedType = FullType.unspecified}) {
    return object.match(
      loading: () => <Object>['loading'],
      noPosts: () => <Object>['noPosts'],
      error: (message) => <Object>[
        'error',
        serializers.serialize(message, specifiedType: const FullType(String))
      ],
      loaded: (posts) => <Object>[
        'loaded',
        serializers.serialize(posts,
            specifiedType: const FullType(List, const [const FullType(Post)]))
      ],
    );
  }

  @override
  HomeViewState deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final iterator = serialized.iterator;
    iterator.moveNext();
    final key = iterator.current as String;
    var result;
    switch (key) {
      case 'loading':
        result = HomeViewState.loading();
        break;
      case 'noPosts':
        result = HomeViewState.noPosts();
        break;
      case 'error':
        iterator.moveNext();
        result = HomeViewState.error(serializers.deserialize(iterator.current,
            specifiedType: const FullType(String)));
        break;
      case 'loaded':
        iterator.moveNext();
        result = HomeViewState.loaded(serializers.deserialize(iterator.current,
            specifiedType: const FullType(List, const [const FullType(Post)])));
        break;
      default:
        throw StateError('Unknown variant $key');
    }
    return result;
  }
}
