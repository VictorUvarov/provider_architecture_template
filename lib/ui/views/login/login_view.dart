import 'package:flutter/material.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/login_model.dart';
import 'package:provider_start/ui/views/base_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).loginViewTitle),
        ),
        body: Center(
          child: FlatButton(
            child: Text(AppLocalizations.of(context).loginButtonText),
            onPressed: model.login,
          ),
        ),
      ),
    );
  }
}
