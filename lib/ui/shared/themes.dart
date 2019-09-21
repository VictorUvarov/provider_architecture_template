import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_start/core/enums/theme_type.dart';

/// List of themes that the app will use.
/// - Themes will used by [ThemeService] in the core/services folder
final materialThemes = {
  ThemeType.Primary: primaryMaterialTheme,
  ThemeType.Dark: darkMaterialTheme,
};

final cupertinoThemes = {
  ThemeType.Primary: primaryCupertinoTheme,
  ThemeType.Dark: darkCupertinoTheme,
};

final primaryMaterialTheme = ThemeData.light()
  ..textTheme.apply(fontFamily: 'Open Sans');
final darkMaterialTheme = ThemeData.dark()
  ..textTheme.apply(fontFamily: 'Open Sans');

final primaryCupertinoTheme = CupertinoThemeData(
  primaryColor: Colors.purple,
  brightness: Brightness.light,
  textTheme: CupertinoTextThemeData(
    primaryColor: Colors.white,
    navTitleTextStyle: TextStyle(
      color: Colors.purple,
    ),
    tabLabelTextStyle: TextStyle(
      color: Colors.purple,
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
