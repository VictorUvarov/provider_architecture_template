import 'package:pedantic/pedantic.dart';

import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/data_sources/posts/posts_local_data_source.dart';
import 'package:provider_start/core/data_sources/users/users_local_data_source.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/hardware_info/hardware_info_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/ui/shared/base_viewmodel_extension.dart';

class StartUpViewModel extends BaseViewModelExt {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final postsLocalDataSource = locator<PostsLocalDataSource>();
  final usersLocalDataSource = locator<UsersLocalDataSource>();
  final hardwareInfoService = locator<HardwareInfoService>();

  Future handleStartUpLogic() async {
    final hasLoggedInUser = await _authService.isUserLoggedIn();

    await Future.wait([
      postsLocalDataSource.init(),
      usersLocalDataSource.init(),
      hardwareInfoService.init(),
    ]);

    if (hasLoggedInUser) {
      unawaited(_navigationService.pushReplacementNamed(ViewRoutes.main));
    } else {
      unawaited(_navigationService.pushReplacementNamed(ViewRoutes.login));
    }
  }
}
