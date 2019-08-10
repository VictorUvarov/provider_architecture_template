import 'package:get_it/get_it.dart';
import 'package:provider_start/core/services/api_service.dart';
import 'package:provider_start/core/services/dialog_service.dart';
import 'package:provider_start/core/services/hardware_service.dart';
import 'package:provider_start/core/services/http_service.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/navigation_service.dart';
import 'package:provider_start/core/ui_models/views/home_model.dart';
import 'package:provider_start/core/ui_models/views/login_model.dart';
import 'package:provider_start/core/ui_models/views/settings_model.dart';
import 'package:provider_start/core/ui_models/views/tab_model.dart';

GetIt locator = GetIt();

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => HardwareService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => HttpService());
  locator.registerLazySingleton(() => ApiService());

  locator.registerFactory(() => TabModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => SettingsModel());

  locator.registerFactory(() => LoginModel());

  await initializeServices();
}

Future<void> initializeServices() async {
  var instance = await KeyStorageService.getInstance();
  locator.registerSingleton<KeyStorageService>(instance);
}
