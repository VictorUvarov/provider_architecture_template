import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/settings_model.dart';
import 'package:provider_start/ui/views/base_view.dart';

part 'settings_view.g.dart';

/// An example settings view that uses platform adaptive widgets
/// and builds widgets using the `functional_widget` package,
/// which avoids the inefficiencies that comes with writing
/// functions that return Widgets. e.g. Widget buildWidget();
///   - To add/change a functional_widget look at README.md - installation section
class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return BaseView<SettingsModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.settingsViewTitle),
          ios: (_) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: ListView(
          children: <Widget>[
            _AppSettingsListTile(model),
            _SignOutListTile(model),
          ],
        ),
      ),
    );
  }
}

@widget
Widget _appSettingsListTile(BuildContext context, SettingsModel model) {
  final local = AppLocalizations.of(context);

  return ListTile(
    title: Text(local.settingsViewAppSettings),
    subtitle: Text(local.settingsViewAppSettingsDesc),
    trailing: Icon(Icons.launch),
    onTap: model.openAppSettings,
  );
}

@widget
Widget _signOutListTile(BuildContext context, SettingsModel model) {
  final local = AppLocalizations.of(context);

  return ListTile(
    title: Text(local.settingsViewSignOut),
    subtitle: Text(local.settingsViewSignOutDesc),
    trailing: Icon(Icons.exit_to_app),
    onTap: () => model.signOut(
      title: local.settingsViewSignOut,
      desc: local.settingsViewSignOutDesc,
      buttonConfirmText: local.buttonTextConfirm,
    ),
  );
}
