import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/localization/localization.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onDenied;
  final VoidCallback onConfirmed;
  final String title;
  final String description;
  final String buttonTitle;

  const ConfirmDialog({
    Key key,
    @required this.title,
    @required this.description,
    @required this.onDenied,
    @required this.onConfirmed,
    this.buttonTitle,
  })  : assert(title != null),
        assert(description != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (onDenied != null) {
          onDenied();
        }
        return false;
      },
      child: PlatformAlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          PlatformDialogAction(
            child: Text(local.buttonCancel),
            onPressed: () {
              if (onDenied != null) {
                onDenied();
              }
            },
          ),
          PlatformDialogAction(
            cupertino: (_, __) =>
                CupertinoDialogActionData(isDestructiveAction: true),
            child: Text(buttonTitle ?? local.buttonConfirm),
            onPressed: () {
              if (onDenied != null) {
                onConfirmed();
              }
            },
          ),
        ],
      ),
    );
  }
}
