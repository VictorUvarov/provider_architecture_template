import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/managers/core_manager.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/ui/router.dart';
import 'package:provider_start/ui/shared/themes.dart' as themes;
import 'package:provider_start/local_setup.dart';
import 'package:provider_start/ui/views/startup/start_up_view.dart';

void main() async {
  /// Because we initialize the app with shared preferences
  /// which uses method channels, we need to init flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();

  /// Setup up services and repositories with our service locator
  await setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return CoreManager(
      child: PlatformApp(
        debugShowCheckedModeBanner: false,
        android: (_) => MaterialAppData(
          theme: themes.primaryMaterialTheme,
          darkTheme: themes.darkMaterialTheme,
        ),
        ios: (_) => CupertinoAppData(
          theme: themes.primaryCupertinoTheme,
        ),
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        localeResolutionCallback: loadSupportedLocals,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        navigatorKey: navigationService.navigatorKey,
        onGenerateRoute: Router.generateRoute,
        home: StartUpView(),
      ),
    );
  }
}
