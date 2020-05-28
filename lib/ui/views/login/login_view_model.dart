import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/exceptions/auth_exception.dart';
import 'package:provider_start/core/mixins/validators.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/state/base_view_model.dart';
import 'package:provider_start/ui/views/login/login_view_state.dart';

class LoginViewModel extends BaseViewModel<LoginViewState> with Validators {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  LoginViewModel() {
    setInitialState(LoginViewState.initial());
  }

  Future<void> login(String email, String password) async {
    setState(LoginViewState.loading());

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      unawaited(_navigationService.popAllAndPushNamed(ViewRoutes.main));
    } on AuthException catch (e) {
      setState(LoginViewState.error(e.message));
    }
  }
}
