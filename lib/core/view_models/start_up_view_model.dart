import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class StartUpViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();

  Future handleStartUpLogic() async {
    final hasLoggedInUser = await _authService.isUserLoggedIn();

    if (hasLoggedInUser) {
      unawaited(Get.offNamed(ViewRoutes.main));
    } else {
      unawaited(Get.offNamed(ViewRoutes.login));
    }
  }
}
