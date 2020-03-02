import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _lightThemeData = ThemeData.light();
final _darkThemeData = ThemeData.dark();

final primaryMaterialTheme = _lightThemeData.copyWith(
  textTheme: _lightThemeData.textTheme.apply(
    fontFamily: 'Open Sans',
  ),
);
final darkMaterialTheme = _darkThemeData.copyWith(
  textTheme: _darkThemeData.textTheme.apply(
    fontFamily: 'Open Sans',
  ),
);

final primaryCupertinoTheme = CupertinoThemeData(
  primaryColor: CupertinoDynamicColor.withBrightness(
    color: Colors.purple,
    darkColor: Colors.cyan,
  ),
);
