import 'package:pedantic/pedantic.dart';
import 'package:provider_start/core/constant/view_routes.dart';
import 'package:provider_start/core/data_sources/posts/posts_local_data_source.dart';
import 'package:provider_start/core/data_sources/users/users_local_data_source.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/hardware_info/hardware_info_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/view_models/base_view_model.dart';
import 'package:provider_start/locator.dart';

class StartUpViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _hardwareInfoService = locator<HardwareInfoService>();
  final _postsLocalDataSource = locator<PostsLocalDataSource>();
  final _usersLocalDataSource = locator<UsersLocalDataSource>();

  Future handleStartUpLogic() async {
    final hasLoggedInUser = await _authService.isUserLoggedIn();

    if (hasLoggedInUser) {
      await Future.wait([
        _hardwareInfoService.init(),
        _postsLocalDataSource.init(),
        _usersLocalDataSource.init(),
      ]);
      unawaited(_navigationService.pushReplacementNamed(ViewRoutes.main));
    } else {
      unawaited(_navigationService.pushReplacementNamed(ViewRoutes.login));
    }
  }
}
