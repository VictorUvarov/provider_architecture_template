import 'package:flutter/cupertino.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/enums/tab_view.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/mixins/validators.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/navigation_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class LoginModel extends BaseModel with Validators {
  final _keyStorageService = locator<KeyStorageService>();
  final _navigationService = locator<NavigationService>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get formKey => _formKey;

  Future<void> init() async {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }

  Future<void> login() async {
    if (!_formKey.currentState.validate()) return;

    setState(ViewState.Busy);

    await Future.delayed(Duration(milliseconds: 250));

    _keyStorageService.hasLoggedIn = true;

    _navigationService.popAllAndPushNamed(
      ViewRoutes.tab_container,
      arguments: TabView.Home,
    );

    setState(ViewState.Idle);
  }
}
