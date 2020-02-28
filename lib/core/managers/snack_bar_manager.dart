import 'package:flushbar/flushbar.dart';
import 'package:provider_start/core/models/snack_bar_request/confirm_snack_bar_request.dart';
import 'package:provider_start/core/models/snack_bar_request/snack_bar_request.dart';
import 'package:provider_start/core/services/snackbar/snack_bar_service.dart';
import 'package:provider_start/locator.dart';
import 'package:flutter/material.dart';

/// Manager that is responsible for showing SnackBar/Flush bar that
/// the [DialogService] requests.

class SnackBarManager extends StatefulWidget {
  final Widget child;
  SnackBarManager({Key key, this.child}) : super(key: key);

  _SnackBarManagerState createState() => _SnackBarManagerState();
}

class _SnackBarManagerState extends State<SnackBarManager> {
  SnackBarService _snackBarService = locator<SnackBarService>();

  @override
  void initState() {
    super.initState();
    _snackBarService.registerSnackBarListener(_showSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showSnackBar(SnackBarRequest request) {
    if (request is ConfirmSnackBarRequest) {
      _showFlushBar(request);
    }
  }

  void _showFlushBar(ConfirmSnackBarRequest request) {
    Flushbar(
      // There is also a messageText property for when you want to
      // use a Text widget and not just a simple String
      // message: 'Hello from a Flushbar',
      message: request.message,
      // Even the button can be styled to your heart's content
      mainButton: FlatButton(
        child: Text(
          request.childtext,
          // style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: () {},
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      // Show it with a cascading operator
    )..show(context);
  }
}
