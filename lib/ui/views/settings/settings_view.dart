import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/models/user_location.dart';
import 'package:provider_start/core/ui_models/views/settings_model.dart';
import 'package:provider_start/ui/views/base_view.dart';

part 'settings_view.g.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).settingsViewTitle),
        ),
        body: ListView(
          children: <Widget>[
            Permissions(model),
            DeleteSomething(model),
            Location(model),
          ],
        ),
      ),
    );
  }
}

@widget
Widget permissions(BuildContext context, SettingsModel model) {
  return ListTile(
    title: Text(AppLocalizations.of(context).settingsViewPermissions),
    subtitle: Text(AppLocalizations.of(context).settingsViewPermissionsDesc),
    trailing: IconButton(
      icon: Icon(Icons.launch),
      onPressed: model.launchAppPermissions,
    ),
  );
}

@widget
Widget deleteSomething(BuildContext context, SettingsModel model) {
  return ListTile(
    title: Text(AppLocalizations.of(context).settingsViewDelete),
    subtitle: Text(AppLocalizations.of(context).settingsViewDeleteDesc),
    trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async => await model.deleteSomething(),
    ),
  );
}

@widget
Widget location(BuildContext context, SettingsModel model) {
  var userLocation = Provider.of<UserLocation>(context);

  return ListTile(
    title: Text(AppLocalizations.of(context).settingsViewLocation),
    subtitle: Text(
      'Lat: ${userLocation?.latitude} Long: ${userLocation?.longitude}',
    ),
  );
}
