import 'package:flutter/material.dart';
import 'package:provider_start/core/constant/route_paths.dart';
import 'package:provider_start/core/enums/tab_view.dart';
import 'package:provider_start/core/managers/dialog_manager.dart';
import 'package:provider_start/ui/views/home/home_view.dart';
import 'package:provider_start/ui/views/settings/settings_view.dart';
import 'package:provider_start/ui/views/tab_container.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      // Tab Views
      case RoutePaths.TabContainer:
        var view = settings.arguments as TabView;
        return MaterialPageRoute(
            builder: (_) => DialogManager(child: TabContainer(view: view)));
      case RoutePaths.Home:
        return MaterialPageRoute(
            builder: (_) => DialogManager(child: HomeView()));
      case RoutePaths.Settings:
        return MaterialPageRoute(
            builder: (_) => DialogManager(child: SettingsView()));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
