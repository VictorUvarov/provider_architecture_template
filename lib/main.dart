import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/managers/core_manager.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/logger.dart';
import 'package:provider_start/provider_setup.dart';
import 'package:provider_start/ui/router.gr.dart';
import 'package:provider_start/ui/shared/themes.dart' as themes;
import 'package:provider_start/local_setup.dart';
import 'package:provider_start/ui/views/startup/start_up_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();
  await setupLocator();

  runZoned(
    () => runApp(MyApp()),
    onError: (e) {
      // Log to crashlytics
    },
  );
}

class MyApp extends StatelessWidget {
  final navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: CoreManager(
        child: PlatformApp(
          debugShowCheckedModeBanner: false,
          material: (_, __) => MaterialAppData(
            theme: themes.primaryMaterialTheme,
            // darkTheme: themes.darkMaterialTheme,
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: themes.primaryCupertinoTheme,
          ),
          localizationsDelegates: localizationsDelegates,
          supportedLocales: supportedLocales,
          localeResolutionCallback: loadSupportedLocals,
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          navigatorKey: navigationService.navigatorKey,
          onGenerateRoute: Router().onGenerateRoute,
          home: StartUpView(),
        ),
      ),
    );
  }
}
