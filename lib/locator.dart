import 'package:get_it/get_it.dart';
import 'package:provider_start/core/enums/theme_type.dart';
import 'package:provider_start/core/services/api_service.dart';
import 'package:provider_start/core/services/background_fetch_service.dart';
import 'package:provider_start/core/services/connectivity_service.dart';
import 'package:provider_start/core/services/dialog_service.dart';
import 'package:provider_start/core/services/hardware_service.dart';
import 'package:provider_start/core/services/http_service.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/navigation_service.dart';
import 'package:provider_start/core/services/theme_service.dart';
import 'package:provider_start/core/ui_models/views/home_model.dart';
import 'package:provider_start/core/ui_models/views/login_model.dart';
import 'package:provider_start/core/ui_models/views/settings_model.dart';
import 'package:provider_start/core/ui_models/views/tab_model.dart';
import 'package:provider_start/core/ui_models/widgets/animated_list_item_model.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => HardwareService());
  locator.registerLazySingleton(() => ConnectivityService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => HttpService());
  locator.registerLazySingleton(() => ApiService());

  // Example, replace with something like location service
  locator.registerLazySingleton(() => BackgroundFetchService());

  // View viewmodels
  locator.registerFactory(() => TabModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => SettingsModel());
  locator.registerFactory(() => LoginModel());

  // Widget viewmodels
  locator.registerFactory(() => AnimatedListItemModel());

  await initializeServices();
}

/// Initialize other services here that require additional code
/// to run before the services can be registered
Future<void> initializeServices() async {
  final instance = await KeyStorageService.getInstance();
  locator.registerSingleton<KeyStorageService>(instance);

  if (instance.nightMode) {
    locator.registerLazySingleton(() => ThemeService(ThemeType.Dark));
  } else {
    locator.registerLazySingleton(() => ThemeService(ThemeType.Primary));
  }
}
