import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider_start/core/enums/theme_type.dart';
import 'package:provider_start/ui/shared/themes.dart';

/// Service that is responsible for changing the theme of the app.
class ThemeService {
  StreamController<ThemeData> _themeController = StreamController<ThemeData>();

  Map<ThemeType, ThemeData> _availableThemes = themes;

  Stream<ThemeData> get theme => _themeController.stream;

  ThemeData _currentTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeService({ThemeType theme}) {
    if (theme != null) {
      final themeToApply = _availableThemes[theme];
      _themeController.add(themeToApply);
      _currentTheme = themeToApply;
    }
  }

  Future<void> changeTheme(ThemeType theme) async {
    final themeToApply = _availableThemes[theme];

    _themeController.add(themeToApply);
    _currentTheme = themeToApply;
  }
}
