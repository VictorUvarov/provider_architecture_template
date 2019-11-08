import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/managers/core_manager.dart';
import 'package:provider_start/core/managers/dialog_manager.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/provider_setup.dart';
import 'package:provider_start/ui/router.dart';
import 'package:provider_start/ui/shared/themes.dart' as themes;
import 'package:provider_start/ui/views/login/login_view.dart';
import 'package:provider_start/ui/views/splash/splash_view.dart';
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
      child: CoreManager(
        child: PlatformApp(
          android: (_) => MaterialAppData(
            theme: themes.primaryMaterialTheme,
            darkTheme: themes.darkMaterialTheme,
          ),
          ios: (_) => CupertinoAppData(
            theme: themes.primaryCupertinoTheme,
            // TODO: When flutter adds dark cupertino support
            // darkTheme: darkCupertinoTheme,
          ),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          localeResolutionCallback: loadSupportedLocals,
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          navigatorKey: navigationService.navigatorKey,
          onGenerateRoute: (settings) =>
              Router.generateRoute(context, settings),
          builder: _setupDialogManager,
          home: _getStartupScreen(),
        ),
      ),
    );
  }

  /// Builder function provided by MaterialApp to place it above the
  /// Navigator of the App. Which means we also give it it's
  /// own navigator to dismiss and show alerts on.
  Widget _setupDialogManager(context, widget) {
    return Navigator(
      key: locator<DialogService>().dialogNavigationKey,
      onGenerateRoute: (settings) => platformPageRoute(
        context: context,
        builder: (context) => DialogManager(child: widget),
      ),
    );
  }

  /// Gets the current View that should show. This function
  /// determines which page to show according to whether
  /// the user has logged in already. Could be used for sign up, etc...
  Widget _getStartupScreen() {
    final keyStorageService = locator<KeyStorageService>();

    if (!keyStorageService.hasLoggedIn) {
      return LoginView();
    }

    return SplashView();
  }
}
