import 'package:pedantic/pedantic.dart';

import '../../../core/constant/view_routes.dart';
import '../../../core/enums/view_state.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../core/mixins/validators.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/services/navigation/navigation_service.dart';
import '../../../locator.dart';
import '../../shared/base_viewmodel_extension.dart';

class LoginViewModel extends BaseViewModelExt with Validators {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  Future<void> login(String email, String password) async {
    setState(ViewState.Busy);

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      unawaited(_navigationService.popAllAndPushNamed(ViewRoutes.main));
    } on AuthException {
      setState(ViewState.Error);
    }
  }
}
