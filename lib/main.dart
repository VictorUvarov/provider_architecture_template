import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'core/localization/localization.dart';
import 'core/managers/core_manager.dart';
import 'core/services/navigation/navigation_service.dart';
import 'core/utils/logger.dart';
import 'local_setup.dart';
import 'locator.dart';
import 'provider_setup.dart';
import 'ui/router.dart';
import 'ui/shared/themes.dart' as themes;
import 'ui/views/startup/start_up_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();
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
          ),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          localeResolutionCallback: loadSupportedLocals,
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          navigatorKey: navigationService.navigatorKey,
          onGenerateRoute: Router.generateRoute,
          home: StartUpView(),
        ),
      ),
    );
  }
}
