import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/ui/views/settings/settings_view_model.dart';
import 'package:stacked/stacked.dart';

/// An example settings view that uses platform adaptive widgets
/// and builds widgets using the `provider_architecture` package,
class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelBuilder<SettingsViewModel>.nonReactive(
      viewModelBuilder: () => SettingsViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.settingsViewTitle),
          cupertino: (_, __) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: ListView(
          children: <Widget>[
            _AppSettingsListTile(),
            _NotificationsListTile(),
            _ShowSnackBarListTile(),
            _SignOutListTile()
          ],
        ),
      ),
    );
  }
}

class _AppSettingsListTile extends ViewModelWidget<SettingsViewModel> {
  const _AppSettingsListTile({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      material: (_, __) => ListTile(
        title: Text(local.settingsViewAppSettings),
        subtitle: Text(local.settingsViewAppSettingsDesc),
        trailing: PlatformWidget(
          material: (_, __) => Icon(Icons.launch),
          cupertino: (_, __) => Icon(CupertinoIcons.share_up),
        ),
        onTap: model.openAppSettings,
      ),
      cupertino: (_, __) => CupertinoButton(
        onPressed: model.openAppSettings,
        child: Row(
          children: <Widget>[
            Text(
              local.settingsViewAppSettings,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Spacer(),
            PlatformWidget(
              material: (_, __) => Icon(Icons.launch),
              cupertino: (_, __) => Icon(CupertinoIcons.share_up),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsListTile extends ViewModelWidget<SettingsViewModel> {
  const _NotificationsListTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      material: (_, __) => ListTile(
        onTap: model.toggleNotificationsEnabled,
        title: Text(local.settingsViewNotifications),
        subtitle: Text(local.settingsViewNotificationsDesc),
        trailing: Switch.adaptive(
          value: model.notificationsEnabled,
          onChanged: (_) => model.toggleNotificationsEnabled(),
        ),
      ),
      cupertino: (_, __) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Text(
              local.settingsViewNotifications,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Spacer(),
            Switch.adaptive(
              value: model.notificationsEnabled,
              onChanged: (_) => model.toggleNotificationsEnabled(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignOutListTile extends ViewModelWidget<SettingsViewModel> {
  const _SignOutListTile({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      material: (_, __) => ListTile(
        title: Text(local.settingsViewSignOut),
        subtitle: Text(local.settingsViewSignOutDesc),
        trailing: PlatformWidget(
          material: (_, __) => Icon(Icons.exit_to_app),
          cupertino: (_, __) => Icon(CupertinoIcons.right_chevron),
        ),
        onTap: model.signOut,
      ),
      cupertino: (_, __) => CupertinoButton(
        onPressed: model.signOut,
        child: Row(
          children: <Widget>[
            Text(
              local.settingsViewSignOut,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Spacer(),
            PlatformWidget(
              material: (_, __) => Icon(Icons.exit_to_app),
              cupertino: (_, __) => Icon(CupertinoIcons.right_chevron),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowSnackBarListTile extends ViewModelWidget<SettingsViewModel> {
  const _ShowSnackBarListTile({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      material: (_, __) => ListTile(
        title: Text(local.settingsViewSnackBar),
        subtitle: Text(local.settingsViewSnackBarDesc),
        trailing: Icon(Icons.announcement),
        onTap: model.showSnackbar,
      ),
      cupertino: (_, __) => CupertinoButton(
        onPressed: model.showSnackbar,
        child: Row(
          children: <Widget>[
            Text(
              local.settingsViewSnackBar,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Spacer(),
            Icon(CupertinoIcons.conversation_bubble),
          ],
        ),
      ),
    );
  }
}
