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
  primaryColor: Colors.blue,
  brightness: Brightness.light,
  textTheme: CupertinoTextThemeData(
    primaryColor: Colors.blue,
    navTitleTextStyle: TextStyle(
      color: Colors.blue,
    ),
    tabLabelTextStyle: TextStyle(
      color: Colors.blue,
    ),
  ),
);

final darkCupertinoTheme = CupertinoThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.black87,
  barBackgroundColor: Colors.black12,
  brightness: Brightness.dark,
  textTheme: CupertinoTextThemeData(
    primaryColor: Colors.white,
    navTitleTextStyle: TextStyle(
      color: Colors.blue,
    ),
    tabLabelTextStyle: TextStyle(
      color: Colors.blue,
    ),
  ),
);
