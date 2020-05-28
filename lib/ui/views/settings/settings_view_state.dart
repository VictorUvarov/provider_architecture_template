import 'package:built_union/built_union.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';

part 'settings_view_state.g.dart';

@BuiltUnion()
class SettingsViewState extends _$SettingsViewState {
  SettingsViewState.loading() : super.loading();
  SettingsViewState.loaded(bool notificationsEnabled)
      : super.loaded(notificationsEnabled);
  SettingsViewState.error(String message) : super.error(message);
}
