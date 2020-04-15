import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

extension contextExtension on BuildContext {
  bool get isDark => MediaQuery.platformBrightnessOf(this) == Brightness.dark;
}
