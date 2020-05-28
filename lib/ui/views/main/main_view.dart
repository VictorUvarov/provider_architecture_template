import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/ui/views/home/home_view.dart';
import 'package:provider_start/ui/views/main/main_view_model.dart';
import 'package:provider_start/ui/views/settings/settings_view.dart';
import 'package:provider_start/ui/widgets/lazy_index_stack.dart';

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

    return ChangeNotifierProvider<MainViewModel>.value(
      value: MainViewModel(),
      builder: (context, child) {
        final model = context.watch<MainViewModel>();

        return PlatformScaffold(
          body: model.state.match(
            initial: (index) => LazyIndexedStack(
              reuse: true,
              index: index,
              itemCount: _views.length,
              itemBuilder: (_, index) => _views[index],
            ),
          ),
          bottomNavBar: model.state.match(
            initial: (index) => PlatformNavBar(
              currentIndex: index,
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
      },
    );
  }
}
