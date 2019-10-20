// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class _FormContainer extends StatelessWidget {
  const _FormContainer(
      {Key key, @required this.formKey, @required this.children})
      : super(key: key);

  final Key formKey;

  final List<Widget> children;

  @override
  Widget build(BuildContext _context) =>
      _formContainer(key, formKey: formKey, children: children);
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField(this.model, {Key key}) : super(key: key);

  final LoginModel model;

  @override
  Widget build(BuildContext _context) => _emailTextField(_context, model);
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField(this.model, {Key key}) : super(key: key);

  final LoginModel model;

  @override
  Widget build(BuildContext _context) => _passwordTextField(_context, model);
}

class _SignInButton extends StatelessWidget {
  const _SignInButton(this.model, {Key key}) : super(key: key);

  final LoginModel model;

  @override
  Widget build(BuildContext _context) => _signInButton(_context, model);
}
