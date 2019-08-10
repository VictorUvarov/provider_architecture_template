import 'package:provider_start/core/constant/route_paths.dart';
import 'package:provider_start/core/enums/tab_view.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/navigation_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class LoginModel extends BaseModel {
  final _keyStorageService = locator<KeyStorageService>();
  final _navigationService = locator<NavigationService>();

  Future<void> init() async {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }

  Future<void> login() async {
    setState(ViewState.Busy);

    _keyStorageService.hasLoggedIn = true;

    _navigationService.nPushNamedAndRemoveUntil(
      RoutePaths.TabContainer,
      arguments: TabView.Home,
    );

    setState(ViewState.Idle);
  }
}
