import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/view_models/login_view_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelProvider<LoginViewModel>.withoutConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text(local.loginViewTitle),
        ),
        body: Form(
          key: model.formKey,
          child: _Container(
            children: <Widget>[
              _EmailTextField(),
              UIHelper.verticalSpaceMedium(),
              _PasswordTextField(),
              UIHelper.verticalSpaceMedium(),
              _SignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  final List<Widget> children;

  const _Container({Key key, @required this.children})
      : assert(children != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

class _EmailTextField extends ProviderWidget<LoginViewModel> {
  @override
  Widget build(BuildContext context, LoginViewModel model) {
    final local = AppLocalizations.of(context);

    return TextFormField(
      controller: model.emailController,
      validator: model.validateEmail,
      onFieldSubmitted: (_) => model.passwordFocusNode.requestFocus(),
      textInputAction: TextInputAction.next,
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
  @override
  Widget build(BuildContext context, LoginViewModel model) {
    final local = AppLocalizations.of(context);

    return TextFormField(
      controller: model.passwordController,
      validator: model.validatePassword,
      focusNode: model.passwordFocusNode,
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
