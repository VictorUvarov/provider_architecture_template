import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/exceptions/auth_exception.dart';
import 'package:provider_start/core/mixins/validators.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/utils/simple_log_printer.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class LoginViewModel extends BaseViewModel with Validators {
  final _log = getLogger();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  bool get busy => state == ViewState.Busy;

  Future<void> login(String email, String password) async {
    _log.d('email:$email password:$password');
    setState(ViewState.Busy);

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      unawaited(_navigationService.popAllAndPushNamed(ViewRoutes.splash));
    } on AuthException {
      setState(ViewState.Error);
    }
  }
}
