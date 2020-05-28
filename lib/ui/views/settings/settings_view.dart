import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/ui/views/settings/settings_view_model.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';
import 'package:stacked/stacked.dart';

/// An example settings view that uses platform adaptive widgets
/// and builds widgets using the `provider_architecture` package,
class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel()..init(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.settingsViewTitle),
          ios: (_) => CupertinoNavigationBarData(
            transitionBetweenRoutes: false,
          ),
        ),
        body: model.state.match(
          loading: () => _LoadingProfile(),
          error: (message) => _ErrorUI(
            message: message,
          ),
          loaded: (notificationsEnabled) => ListView(
            children: <Widget>[
              _AppSettingsListTile(),
              _NotificationsListTile(
                enabled: notificationsEnabled,
              ),
              _ShowSnackBarListTile(),
              _SignOutListTile()
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingProfile extends StatelessWidget {
  const _LoadingProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimation(),
    );
  }
}

class _ErrorUI extends StatelessWidget {
  final String message;

  const _ErrorUI({
    Key key,
    @required this.message,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

class _AppSettingsListTile extends ViewModelWidget<SettingsViewModel> {
  _AppSettingsListTile({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      android: (_) => ListTile(
        title: Text(local.settingsViewAppSettings),
        subtitle: Text(local.settingsViewAppSettingsDesc),
        trailing: PlatformWidget(
          android: (_) => Icon(Icons.launch),
          ios: (_) => Icon(CupertinoIcons.share_up),
        ),
        onTap: model.openAppSettings,
      ),
      ios: (_) => CupertinoButton(
        onPressed: model.openAppSettings,
        child: Row(
          children: <Widget>[
            Text(
              local.settingsViewAppSettings,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Spacer(),
            PlatformWidget(
              android: (_) => Icon(Icons.launch),
              ios: (_) => Icon(CupertinoIcons.share_up),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationsListTile extends ViewModelWidget<SettingsViewModel> {
  final bool enabled;

  const _NotificationsListTile({
    Key key,
    @required this.enabled,
  })  : assert(enabled != null),
        super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      android: (_) => ListTile(
        onTap: model.toggleNotificationsEnabled,
        title: Text(local.settingsViewNotifications),
        subtitle: Text(local.settingsViewNotificationsDesc),
        trailing: Switch.adaptive(
          value: enabled,
          onChanged: (_) => model.toggleNotificationsEnabled(),
        ),
      ),
      ios: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Text(
              local.settingsViewNotifications,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Spacer(),
            Switch.adaptive(
              value: enabled,
              onChanged: (_) => model.toggleNotificationsEnabled(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignOutListTile extends ViewModelWidget<SettingsViewModel> {
  _SignOutListTile({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      android: (_) => ListTile(
        title: Text(local.settingsViewSignOut),
        subtitle: Text(local.settingsViewSignOutDesc),
        trailing: PlatformWidget(
          android: (_) => Icon(Icons.exit_to_app),
          ios: (_) => Icon(CupertinoIcons.right_chevron),
        ),
        onTap: model.signOut,
      ),
      ios: (_) => CupertinoButton(
        onPressed: model.signOut,
        child: Row(
          children: <Widget>[
            Text(
              local.settingsViewSignOut,
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
            Spacer(),
            PlatformWidget(
              android: (_) => Icon(Icons.exit_to_app),
              ios: (_) => Icon(CupertinoIcons.right_chevron),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowSnackBarListTile extends ViewModelWidget<SettingsViewModel> {
  _ShowSnackBarListTile({Key key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SettingsViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      android: (_) => ListTile(
        title: Text(local.settingsViewSnackBar),
        subtitle: Text(local.settingsViewSnackBarDesc),
        trailing: Icon(Icons.announcement),
        onTap: model.showSnackbar,
      ),
      ios: (_) => CupertinoButton(
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
