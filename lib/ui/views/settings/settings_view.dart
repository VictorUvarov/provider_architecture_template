import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/settings_model.dart';
import 'package:provider_start/ui/views/base_view.dart';

part 'settings_view.g.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(AppLocalizations.of(context).settingsViewTitle),
        ),
        body: ListView(
          children: <Widget>[
            DeleteSomething(model),
            EnableDarkTheme(model),
          ],
        ),
      ),
    );
  }
}

@widget
Widget deleteSomething(BuildContext context, SettingsModel model) {
  return ListTile(
    title: Text(AppLocalizations.of(context).settingsViewDelete),
    subtitle: Text(AppLocalizations.of(context).settingsViewDeleteDesc),
    trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        await model.deleteSomething();
      },
    ),
  );
}

@widget
Widget enableDarkTheme(BuildContext context, SettingsModel model) {
  return ListTile(
    title: Text(AppLocalizations.of(context).settingsViewNightMode),
    trailing: PlatformSwitch(
      onChanged: (bool value) async {
        await model.toggleNightMode(value);
      },
      value: model.isNightMode,
    ),
  );
}
