import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/ui_models/views/login_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/views/base_view.dart';

part 'login_view.g.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return BaseView<LoginModel>(
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.loginViewTitle),
          ios: (_) => CupertinoNavigationBarData(
            previousPageTitle: local.loginViewTitle,
            transitionBetweenRoutes: false,
          ),
        ),
        body: _FormContainer(
          formKey: model.formKey,
          children: <Widget>[
            _EmailTextField(model),
            UIHelper.verticalSpaceMedium(),
            _PasswordTextField(model),
            UIHelper.verticalSpaceMedium(),
            _SignInButton(model),
          ],
        ),
      ),
    );
  }
}

@widget
Widget _formContainer(
  Key key, {
  @required Key formKey,
  @required List<Widget> children,
}) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          children: children,
        ),
      ),
    ),
  );
}

@widget
Widget _emailTextField(BuildContext context, LoginModel model) {
  final local = AppLocalizations.of(context);

  return TextFormField(
    controller: model.emailController,
    validator: model.validateEmail,
    decoration: InputDecoration(
      hintText: local.emailHintText,
      contentPadding: const EdgeInsets.all(8),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}

@widget
Widget _passwordTextField(BuildContext context, LoginModel model) {
  final local = AppLocalizations.of(context);

  return TextFormField(
    controller: model.passwordController,
    validator: model.validatePassword,
    obscureText: true,
    textInputAction: TextInputAction.send,
    onFieldSubmitted: (_) => model.login(),
    decoration: InputDecoration(
      hintText: local.passwordHintText,
      contentPadding: const EdgeInsets.all(8),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  );
}

@widget
Widget _signInButton(BuildContext context, LoginModel model) {
  final local = AppLocalizations.of(context);
  final theme = Theme.of(context);

  return model.state == ViewState.Busy
      ? PlatformCircularProgressIndicator()
      : PlatformButton(
          child: Text(local.loginButtonText),
          onPressed: model.login,
          android: (context) => MaterialRaisedButtonData(
            textTheme: ButtonTextTheme.primary,
            color: theme.primaryColor,
          ),
        );
}
