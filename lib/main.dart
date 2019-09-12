import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/managers/dialog_manager.dart';
import 'package:provider_start/core/managers/lifecycle_manager.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/navigation_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/provider_setup.dart';
import 'package:provider_start/ui/router.dart';
import 'package:provider_start/ui/views/login/login_view.dart';
import 'package:provider_start/ui/views/splash/splash_view.dart';
import 'package:provider_start/core/utils/local.dart' as localUtils;
import 'package:provider_start/local_setup.dart';

void main() async {
  await setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<ThemeData>(
        builder: (context, theme, child) => LifeCycleManager(
          child: MaterialApp(
            theme: theme,
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: supportedLocales,
            localeResolutionCallback: localUtils.loadSupportedLocals,
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            navigatorKey: navigationService.navigatorKey,
            onGenerateRoute: Router.generateRoute,
            builder: _setupDialogManager,
            home: _getStartupScreen(),
          ),
        ),
      ),
    );
  }

  /// Builder function provided by MaterialApp to place it above the
  /// Navigator of the App. Which means we also give it it's
  /// own navigator to dismiss and show alerts on.
  Widget _setupDialogManager(context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            child: widget,
          ),
        ),
      );

  /// Gets the current View that should show. This function
  /// determines which page to show according to whether
  /// the user has logged in already. Could be used for signup, etc...
  Widget _getStartupScreen() {
    final localStorageService = locator<KeyStorageService>();

    if (!localStorageService.hasLoggedIn) {
      return LoginView();
    }

    return SplashView();
  }
}
