import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../core/localization/localization.dart';
import '../../widgets/lazy_index_stack.dart';
import '../home/home_view.dart';
import '../settings/settings_view.dart';
import 'main_viewmodel.dart';

/// Main view container that handles rendering pages according to which bottom
/// navigation bar item is tapped
///   - can be replaced with a [TabView]
class MainView extends StatelessWidget {
  final _views = [
    HomeView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        body: LazyIndexedStack(
          reuse: true,
          index: model.index,
          itemCount: _views.length,
          itemBuilder: (_, index) => _views[index],
        ),
        bottomNavBar: PlatformNavBar(
          currentIndex: model.index,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: PlatformWidget(
                android: (_) => Icon(Icons.home),
                ios: (_) => Icon(CupertinoIcons.home),
              ),
              title: Text(local.homeViewTitle),
            ),
            BottomNavigationBarItem(
              icon: PlatformWidget(
                android: (_) => Icon(Icons.settings),
                ios: (_) => Icon(CupertinoIcons.settings),
              ),
              title: Text(local.settingsViewTitle),
            ),
          ],
          itemChanged: model.changeTab,
        ),
      ),
    );
  }
}
