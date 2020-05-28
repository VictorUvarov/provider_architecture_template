import 'package:built_union/built_union.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'login_view_state.g.dart';

@BuiltUnion()
class LoginViewState extends _$LoginViewState {
  LoginViewState.initial() : super.initial();
  LoginViewState.loading() : super.loading();
  LoginViewState.error(String message) : super.error(message);
}
