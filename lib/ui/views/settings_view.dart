import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/models/user_location/user_location.dart';
import 'package:provider_start/core/view_models/settings_view_model.dart';

/// An example settings view that uses platform adaptive widgets
/// and builds widgets using the `functional_widget` package,
/// which avoids the inefficiencies that comes with writing
/// functions that return Widgets. e.g. Widget buildWidget();
///   - To add/change a functional_widget look at README.md - installation section
class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelProvider<SettingsViewModel>.withoutConsumer(
      viewModel: SettingsViewModel(),
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
            _AppSettingsListTile(),
            _LocationListTile(),
            _SignOutListTile(),
          ],
        ),
      ),
    );
  }
}

class _AppSettingsListTile extends ProviderWidget<SettingsViewModel> {
  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return ListTile(
      title: Text(local.settingsViewAppSettings),
      subtitle: Text(local.settingsViewAppSettingsDesc),
      trailing: PlatformWidget(
        android: (_) => Icon(Icons.launch),
        ios: (_) => Icon(CupertinoIcons.share_up),
      ),
      onTap: model.openAppSettings,
    );
  }
}

class _LocationListTile extends ProviderWidget<SettingsViewModel> {
  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);
    final location = Provider.of<UserLocation>(context);

    return ListTile(
      title: Text(local.settingsViewLocation),
      subtitle: Text(
        location == null
            ? 'Unknown'
            : 'Lat: ${location?.latitude} Long: ${location?.longitude}',
      ),
      trailing: Icon(Icons.location_on),
    );
  }
}

class _SignOutListTile extends ProviderWidget<SettingsViewModel> {
  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return ListTile(
      title: Text(local.settingsViewSignOut),
      subtitle: Text(local.settingsViewSignOutDesc),
      trailing: PlatformWidget(
        android: (_) => Icon(Icons.exit_to_app),
        ios: (_) => Icon(CupertinoIcons.right_chevron),
      ),
      onTap: () => model.signOut(
        title: local.settingsViewSignOut,
        desc: local.settingsViewSignOutDesc,
        buttonConfirmText: local.buttonTextConfirm,
      ),
    );
  }
}
