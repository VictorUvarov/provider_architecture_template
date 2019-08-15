import 'package:flutter/material.dart';
import 'package:provider_start/core/enums/tab_view.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/tab_model.dart';
import 'package:provider_start/ui/views/base_view.dart';
import 'package:provider_start/ui/views/home/home_view.dart';
import 'package:provider_start/ui/views/settings/settings_view.dart';
import 'package:provider_start/ui/widgets/platform_adaptive.dart';

class TabContainer extends StatelessWidget {
  final TabView view;

  TabContainer({Key key, @required this.view})
      : assert(view != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TabModel>(
      onModelReady: (model) => model.init(view),
      builder: (context, model, child) => Scaffold(
        body: IndexedStack(
          index: model.currentTab,
          children: [
            HomeView(),
            SettingsView(),
          ],
        ),
        bottomNavigationBar: PlatformAdaptiveBottomBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(AppLocalizations.of(context).homeViewTitle),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context).settingsViewTitle),
            ),
          ],
          currentIndex: model.currentTab,
          onTap: model.changeTab,
        ),
      ),
    );
  }
}
