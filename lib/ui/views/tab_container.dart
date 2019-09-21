import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/enums/tab_view.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/tab_model.dart';
import 'package:provider_start/ui/views/base_view.dart';
import 'package:provider_start/ui/views/home/home_view.dart';
import 'package:provider_start/ui/views/settings/settings_view.dart';

final Key _homeViewKey = PageStorageKey('HomeView');
final Key _settingsViewKey = PageStorageKey('SettingsView');

/// A view that wraps other views and displays whichever
/// page is currently selected on the [BottomNavigationBar]
/// or in this case [PlatformNavBar]
class TabContainer extends StatelessWidget {
  final TabView view;

  TabContainer({Key key, @required this.view})
      : assert(view != null),
        super(key: key);

  final PageStorageBucket bucket = PageStorageBucket();

  final _views = [
    HomeView(key: _homeViewKey),
    SettingsView(key: _settingsViewKey),
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return BaseView<TabModel>(
      onModelReady: (model) => model.init(view),
      builder: (context, model, child) => PlatformScaffold(
        body: PageStorage(
          child: _views[model.currentTab],
          bucket: bucket,
        ),
        bottomNavBar: PlatformNavBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(local.homeViewTitle),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(local.settingsViewTitle),
            ),
          ],
          currentIndex: model.currentTab,
          itemChanged: model.changeTab,
        ),
      ),
    );
  }
}
