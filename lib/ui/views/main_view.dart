import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/view_models/main_view_model.dart';
import 'package:provider_start/ui/views/home_view.dart';
import 'package:provider_start/ui/views/settings_view.dart';

/// Main view container that handles rendering pages according to which bottom
/// navigation bar item is tapped
///   - can be replaced with a [TabView]
class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelProvider<MainViewModel>.withConsumer(
      viewModel: MainViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        body: IndexedStack(
          index: model.index,
          children: <Widget>[
            HomeView(),
            SettingsView(),
          ],
        ),
        bottomNavBar: PlatformNavBar(
          currentIndex: model.index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(local.homeViewTitle),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(local.settingsViewTitle),
            ),
          ],
          itemChanged: model.changeTab,
        ),
      ),
    );
  }
}
