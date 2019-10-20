import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/ui/views/home/home_view.dart';
import 'package:provider_start/ui/views/settings/settings_view.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  
  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          HomeView(),
          SettingsView(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: theme.indicatorColor,
        labelColor: theme.primaryColor,
        unselectedLabelColor: theme.unselectedWidgetColor,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.home),
            text: local.homeViewTitle,
          ),
          Tab(
            icon: Icon(Icons.settings),
            text: local.settingsViewTitle,
          ),
        ],

      ),
    );
  }
}