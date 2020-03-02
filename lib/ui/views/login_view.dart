import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/localization/localization.dart';
import 'package:provider_start/core/view_models/login_view_model.dart';
import 'package:provider_start/ui/shared/ui_helper.dart';
import 'package:provider_start/ui/widgets/cupertino/cupertino_text_form_field.dart';
import 'package:provider_start/ui/widgets/loading_animation.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ViewModelProvider<LoginViewModel>.withoutConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(model.viewFocusNode),
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(local.loginViewTitle),
            ios: (_) => CupertinoNavigationBarData(previousPageTitle: ''),
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
        child: ListView(
          padding: const EdgeInsets.all(12),
          shrinkWrap: true,
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

    return PlatformWidget(
      android: (_) => TextFormField(
        controller: model.emailController,
        validator: (value) {
          final key = model.validateEmail(value);
          return local.translate(key);
        },
        onFieldSubmitted: (_) => model.passwordFocusNode.requestFocus(),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: local.emailHintText,
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
      ios: (_) => CupertinoTextFormField(
        validator: (value) {
          final email = model.emailController.text;
          final key = model.validateEmail(email);
          return local.translate(key);
        },
        onFieldSubmitted: (_) => model.passwordFocusNode.requestFocus(),
        controller: model.emailController,
        placeholder: local.emailHintText,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        prefix: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(CupertinoIcons.mail),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _PasswordTextField extends ProviderWidget<LoginViewModel> {
  @override
  Widget build(BuildContext context, LoginViewModel model) {
    final local = AppLocalizations.of(context);

    return PlatformWidget(
      android: (_) => TextFormField(
        controller: model.passwordController,
        validator: (value) {
          final key = model.validatePassword(value);
          return local.translate(key);
        },
        focusNode: model.passwordFocusNode,
        obscureText: true,
        textInputAction: TextInputAction.send,
        onFieldSubmitted: (_) => model.login(),
        decoration: InputDecoration(
          hintText: local.passwordHintText,
          prefixIcon: Icon(Icons.lock),
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
      ios: (_) => CupertinoTextFormField(
        validator: (value) {
          final password = model.passwordController.text;
          final key = model.validatePassword(password);
          return local.translate(key);
        },
        controller: model.passwordController,
        focusNode: model.passwordFocusNode,
        placeholder: local.passwordHintText,
        obscureText: true,
        onFieldSubmitted: (_) => model.login(),
        textInputAction: TextInputAction.send,
        prefix: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(CupertinoIcons.padlock),
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8),
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

    if (model.state == ViewState.Busy) {
      return LoadingAnimation();
    }

    return PlatformButton(
      child: Text(local.loginButtonText),
      onPressed: model.login,
      android: (_) => MaterialRaisedButtonData(
        textTheme: ButtonTextTheme.primary,
        color: theme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
