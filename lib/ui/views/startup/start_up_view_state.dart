import 'package:built_union/built_union.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'start_up_view_state.g.dart';

@BuiltUnion()
class StartupViewState extends _$StartupViewState {
  StartupViewState.loading() : super.loading();
}
