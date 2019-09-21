import 'package:flutter/material.dart';

class ThemeManager extends StatelessWidget {
  final Widget child;
  final ThemeData data;

  const ThemeManager({Key key, @required this.child, this.data})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return AnimatedTheme(
        child: child,
        data: data,
        duration: const Duration(milliseconds: 2000),
        curve: ElasticInOutCurve(),
      );
    }
    return child;
  }
}
