import 'package:flutter/material.dart';
import 'package:provider_start/core/services/theme_service.dart';
import 'package:provider_start/locator.dart';

class ThemeManager extends StatelessWidget {
  final Widget child;
  final ThemeData themeData;

  const ThemeManager({Key key, @required this.child, this.themeData})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = locator<ThemeService>().currentTheme;

    return AnimatedTheme(
      child: child,
      data: themeData ?? currentTheme,
      duration: const Duration(milliseconds: 2000),
      curve: ElasticInOutCurve(),
    );
  }
}
