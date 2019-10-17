import 'package:provider_start/core/enums/theme_type.dart';
import 'package:provider_start/core/models/platform_theme.dart';

abstract class ThemeService {
  Stream<PlatformThemeData> get theme$;

  void changeTheme(ThemeType theme);
}
