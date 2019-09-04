import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider_start/core/enums/theme_type.dart';
import 'package:provider_start/ui/shared/themes.dart';

/// Service that is responsible for changing the theme of the app.
class ThemeService {
  StreamController<ThemeData> _themeController = StreamController<ThemeData>();

  Map<ThemeType, ThemeData> _availableThemes = themes;

  Stream<ThemeData> get theme => _themeController.stream;

  ThemeService({ThemeType theme}) {
    if (theme != null) {
      var themeToApply = _availableThemes[theme];
      _themeController.add(themeToApply);
    }
  }

  Future<void> changeTheme(ThemeType theme) async {
    var themeToApply = _availableThemes[theme];

    _themeController.add(themeToApply);
  }
}
