import 'package:get_it/get_it.dart';
import 'package:provider_start/core/services/api/api_service.dart';
import 'package:provider_start/core/services/api/api_service_impl.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/auth/auth_service_impl.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service_impl.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/dialog/dialog_service_impl.dart';
import 'package:provider_start/core/services/hardware/hardware_service.dart';
import 'package:provider_start/core/services/hardware/hardware_service_impl.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/core/services/http/http_service_impl.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service_impl.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service_impl.dart';
import 'package:provider_start/core/ui_models/views/home_model.dart';
import 'package:provider_start/core/ui_models/views/login_model.dart';
import 'package:provider_start/core/ui_models/views/main_model.dart';
import 'package:provider_start/core/ui_models/views/settings_model.dart';
import 'package:provider_start/core/ui_models/widgets/animated_list_item_model.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator() async {
  locator.registerLazySingleton<NavigationService>(
    () => NavigationServiceImpl(),
  );
  locator.registerLazySingleton<HardwareService>(() => HardwareServiceImpl());
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());
  locator.registerLazySingleton<ApiService>(() => ApiServiceImpl());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());

  // View view models
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => SettingsModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => MainModel());

  // Widget view models
  locator.registerFactory(() => AnimatedListItemModel());

  await initializeServices();
}

/// Initialize other services here that require additional code
/// to run before the services can be registered
Future<void> initializeServices() async {
  final instance = await KeyStorageServiceImpl.getInstance();
  locator.registerSingleton<KeyStorageService>(instance);
}
