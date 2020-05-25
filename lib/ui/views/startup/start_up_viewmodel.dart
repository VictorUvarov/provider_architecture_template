import 'package:pedantic/pedantic.dart';

import '../../../core/constant/view_routes.dart';
import '../../../core/data_sources/posts/posts_local_data_source.dart';
import '../../../core/data_sources/users/users_local_data_source.dart';
import '../../../core/services/auth/auth_service.dart';
import '../../../core/services/hardware_info/hardware_info_service.dart';
import '../../../core/services/navigation/navigation_service.dart';
import '../../../locator.dart';
import '../../shared/base_viewmodel_extension.dart';

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
