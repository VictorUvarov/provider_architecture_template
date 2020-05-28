import 'package:built_union/built_union.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'main_view_state.g.dart';

@BuiltUnion()
class MainViewState extends _$MainViewState {
  MainViewState.initial(int index) : super.initial(index);
}
