import 'package:flutter/material.dart';
import 'package:provider_start/core/enums/theme_type.dart';

final themes = {
  ThemeType.primary: primary,
  ThemeType.dark: dark,
};

ThemeData primary = ThemeData.light();
ThemeData dark = ThemeData.dark();
