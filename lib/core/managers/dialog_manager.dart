import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/models/alert_request.dart';
import 'package:provider_start/core/models/alert_response.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/locator.dart';

/// Manager that is responsible for showing dialogs that
/// the [DialogService] requests.
class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          _dialogService.dialogComplete(AlertResponse(confirmed: false));
          return false;
        },
        child: PlatformAlertDialog(
          title: Text(request.title),
          content: Text(request.description),
          actions: <Widget>[
            FlatButton(
              child: Text(local.buttonTextCancel),
              onPressed: () {
                _dialogService.dialogComplete(AlertResponse(confirmed: false));
              },
            ),
            PlatformButton(
              child: Text(request.buttonTitle ?? local.buttonTextCancel),
              onPressed: () {
                _dialogService.dialogComplete(AlertResponse(confirmed: true));
              },
              android: (context) => MaterialRaisedButtonData(
                textTheme: ButtonTextTheme.primary,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
