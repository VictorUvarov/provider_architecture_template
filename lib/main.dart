import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/location_permission_service.dart';
import 'package:provider_start/core/services/navigation_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/provider_setup.dart';
import 'package:provider_start/ui/router.dart';
import 'package:provider_start/ui/views/login/login_view.dart';
import 'package:provider_start/ui/views/splash/splash_view.dart';

void main() async {
  await setupLocator();
  await locator<LocationPermissionService>().requestPermission();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
        ],
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: Router.generateRoute,
        home: _getStartupScreen(),
      ),
    );
  }

  Widget _getStartupScreen() {
    var localStorageService = locator<KeyStorageService>();

    if (!localStorageService.hasLoggedIn) {
      return LoginView();
    }

    return SplashView();
  }
}
