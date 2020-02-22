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

  String _email = '';
  String get email => _email;

  String _password = '';
  String get password => _password;

  String _emailErrorMessage;
  String get emailErrorMessage => _emailErrorMessage;

  String _passwordErrorMessage;
  String get passwordErrorMessage => _passwordErrorMessage;

  bool _canSubmitEmail = false;
  bool _canSubmitPassword = false;
  bool get canLoginUser => _canSubmitEmail && _canSubmitPassword;

  void setEmail(String email) {
    _log.d('email:$email');
    _email = email;
    _emailErrorMessage = validateEmail(email);
    _canSubmitEmail = _emailErrorMessage == null;
    notifyListeners();
  }

  void setPassword(String password) {
    _log.d('password:$password');
    _password = password;
    _passwordErrorMessage = validatePassword(password);
    _canSubmitPassword = _passwordErrorMessage == null;
    notifyListeners();
  }

  Future<void> login() async {
    if (!canLoginUser) {
      _emailErrorMessage = validateEmail(email);
      _canSubmitEmail = _emailErrorMessage == null;
      _passwordErrorMessage = validatePassword(password);
      _canSubmitPassword = _passwordErrorMessage == null;
      notifyListeners();
      return;
    }

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
