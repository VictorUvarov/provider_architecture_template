import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/exceptions/auth_exception.dart';
import 'package:provider_start/core/mixins/validators.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class LoginViewModel extends BaseViewModel with Validators {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _viewFocusNode = FocusNode();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  GlobalKey<FormState> get formKey => _formKey;
  FocusNode get viewFocusNode => _viewFocusNode;

  Future<void> login() async {
    if (!_formKey.currentState.validate()) return;

    setState(ViewState.Busy);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      setState(ViewState.Idle);

      unawaited(_navigationService.popAllAndPushNamed(ViewRoutes.splash));
    } on AuthException {
      setState(ViewState.Error);
    }
  }

  @override
  void dispose() {
    _viewFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
