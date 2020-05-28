import 'package:built_union/built_union.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:provider_start/core/models/user/user.dart';

part 'post_details_view_state.g.dart';

@BuiltUnion()
class PostDetailsViewState extends _$PostDetailsViewState {
  PostDetailsViewState.loading() : super.loading();
  PostDetailsViewState.loaded(User user) : super.loaded(user);
  PostDetailsViewState.error(String message) : super.error(message);
}
