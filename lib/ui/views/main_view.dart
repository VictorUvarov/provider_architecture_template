import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/main_model.dart';
import 'package:provider_start/ui/views/base_view.dart';
import 'package:provider_start/ui/views/home/home_view.dart';
import 'package:provider_start/ui/views/settings/settings_view.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return BaseView<MainModel>(
      builder: (context, model, child) => Scaffold(
        body: IndexedStack(
          index: model.currentIndex,
          children: <Widget>[
            HomeView(),
            SettingsView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(local.homeViewTitle)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(local.settingsViewTitle)
            ),
          ],
          onTap: model.changeTab,
        ),
      ),
    );
  }
}
