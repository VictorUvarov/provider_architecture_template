import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/view_models/login_view_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(local.loginViewTitle),
          ),
          body: _Container(
            busy: model.state == ViewState.Busy,
            children: <Widget>[
              _InputField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail,
                labelText: local.emailHintText,
                nextFocus: passwordFocusNode,
                message: model.emailErrorMessage,
                onChanged: model.setEmail,
              ),
              UIHelper.verticalSpaceMedium(),
              _InputField(
                controller: passwordController,
                currentFocus: passwordFocusNode,
                prefixIcon: Icons.lock,
                labelText: local.passwordHintText,
                message: model.passwordErrorMessage,
                obscureText: true,
                onChanged: model.setPassword,
                onEditComplete: model.login,
              ),
              UIHelper.verticalSpaceMedium(),
              _SignInButton(
                busy: model.state == ViewState.Busy,
                onPressed: model.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  final bool busy;
  final List<Widget> children;

  _Container({Key key, this.busy, @required this.children})
      : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: busy,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  final bool busy;
  final Function onPressed;

  const _SignInButton({Key key, this.busy, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return busy
        ? LoadingAnimation()
        : PlatformButton(
            child: Text(local.loginButtonText),
            onPressed: onPressed,
            android: (context) => MaterialRaisedButtonData(
              textTheme: ButtonTextTheme.primary,
              color: theme.primaryColor,
            ),
          );
  }
}

class _InputField extends ProviderWidget<LoginViewModel> {
  final TextEditingController controller;
  final FocusNode currentFocus;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final String labelText;
  final FocusNode nextFocus;
  final String message;
  final bool obscureText;
  final Function onChanged;
  final Function onEditComplete;

  _InputField({
    Key key,
    this.controller,
    this.currentFocus,
    this.keyboardType,
    this.prefixIcon,
    this.labelText,
    this.nextFocus,
    this.message,
    this.obscureText = false,
    this.onChanged,
    this.onEditComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PlatformTextField(
          android: (_) => MaterialTextFieldData(
            decoration: InputDecoration(
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: theme.accentColor)
                  : null,
              border: OutlineInputBorder(),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: (controller.text != null && controller.text != '')
                      ? Colors.black
                      : Colors.black54),
            ),
          ),
          ios: (_) => CupertinoTextFieldData(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            padding: const EdgeInsets.all(12),
          ),
          controller: controller,
          keyboardType: keyboardType,
          textInputAction:
              nextFocus == null ? TextInputAction.go : TextInputAction.next,
          focusNode: currentFocus,
          obscureText: obscureText,
          onChanged: onChanged,
          onEditingComplete: onEditComplete,
          onSubmitted: (term) {
            if (nextFocus == null) {
              currentFocus.unfocus();
            } else {
              FocusScope.of(context).requestFocus(nextFocus);
            }
          },
          style: TextStyle(color: Colors.black),
          textCapitalization: TextCapitalization.none,
        ),
        _FieldErrorMessage(message: message),
      ],
    );
  }
}

class _FieldErrorMessage extends StatelessWidget {
  final String message;

  _FieldErrorMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return message != null
        ? Container(
            margin: EdgeInsets.fromLTRB(12, 8, 0, 0),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(message,
                style: TextStyle(color: Colors.white, fontSize: 12)),
          )
        : Container();
  }
}
