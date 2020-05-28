import 'package:built_union/built_union.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_start/core/models/post/post.dart';

part 'home_view_state.g.dart';

@BuiltUnion()
class HomeViewState extends _$HomeViewState {
  HomeViewState.loading() : super.loading();
  HomeViewState.noPosts() : super.noPosts();
  HomeViewState.error(String message) : super.error(message);
  HomeViewState.loaded(List<Post> posts) : super.loaded(posts);
}
