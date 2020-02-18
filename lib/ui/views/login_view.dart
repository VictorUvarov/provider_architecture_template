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
  GlobalKey<FormState> formKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
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

    return ViewModelProvider<LoginViewModel>.withoutConsumer(
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
          body: Form(
            key: formKey,
            child: _Container(
              children: <Widget>[
                _EmailTextField(
                  formKey: formKey,
                  controller: emailController,
                  nextFocusNode: passwordFocusNode,
                ),
                UIHelper.verticalSpaceMedium(),
                _PasswordTextField(
                  formKey: formKey,
                  controller: passwordController,
                  currentFocusNode: passwordFocusNode,
                ),
                UIHelper.verticalSpaceMedium(),
                _SignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Container extends ProviderWidget<LoginViewModel> {
  final List<Widget> children;

  _Container({Key key, @required this.children})
      : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return IgnorePointer(
      ignoring: model.state == ViewState.Busy,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}

class _EmailTextField extends ProviderWidget<LoginViewModel> {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;

  _EmailTextField({
    this.formKey,
    @required this.controller,
    this.currentFocusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    final local = AppLocalizations.of(context);

    return TextFormField(
      controller: controller,
      validator: model.validateEmail,
      onFieldSubmitted: (_) => nextFocusNode.requestFocus(),
      onChanged: (email) {
        model.setEmail(email);
        formKey.currentState?.validate();
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
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
}

class _PasswordTextField extends ProviderWidget<LoginViewModel> {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;

  _PasswordTextField({
    this.formKey,
    @required this.controller,
    this.currentFocusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    final local = AppLocalizations.of(context);

    return TextFormField(
      controller: controller,
      validator: model.validatePassword,
      focusNode: currentFocusNode,
      obscureText: true,
      textInputAction: TextInputAction.send,
      onChanged: (password) {
        model.setPassword(password);
        formKey.currentState?.validate();
      },
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
}

class _SignInButton extends ProviderWidget<LoginViewModel> {
  @override
  Widget build(BuildContext context, LoginViewModel model) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return model.state == ViewState.Busy
        ? LoadingAnimation()
        : PlatformButton(
            child: Text(local.loginButtonText),
            onPressed: model.login,
            android: (context) => MaterialRaisedButtonData(
              textTheme: ButtonTextTheme.primary,
              color: theme.primaryColor,
            ),
          );
  }
}
