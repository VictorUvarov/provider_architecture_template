import 'package:get_it/get_it.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository.dart';
import 'package:provider_start/core/repositories/posts_repository/posts_repository_impl.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository.dart';
import 'package:provider_start/core/repositories/users_repository/users_repository_impl.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/auth/auth_service_impl.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service.dart';
import 'package:provider_start/core/services/connectivity/connectivity_service_impl.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/dialog/dialog_service_impl.dart';
import 'package:provider_start/core/services/hardware_info/hardware_info_service.dart';
import 'package:provider_start/core/services/hardware_info/hardware_info_service_impl.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service_impl.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service.dart';
import 'package:provider_start/core/services/local_storage/local_storage_service_impl.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service_impl.dart';
import 'package:provider_start/core/view_models/home_view_model.dart';
import 'package:provider_start/core/view_models/login_view_model.dart';
import 'package:provider_start/core/view_models/main_view_model.dart';
import 'package:provider_start/core/view_models/post_details_view_model.dart';
import 'package:provider_start/core/view_models/settings_view_model.dart';
import 'package:provider_start/core/view_models/widgets/animated_list_item_model.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.
Future<void> setupLocator() async {
  // Repositories
  locator.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl());
  locator.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl());

  // Services
  locator.registerLazySingleton<NavigationService>(
    () => NavigationServiceImpl(),
  );
  locator.registerLazySingleton<HardwareInfoService>(
      () => HardwareInfoServiceImpl());
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  locator.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(),
  );

  // View view models
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => SettingsViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => MainViewModel());
  locator.registerFactory(() => PostDetailsViewModel());

  // Widget view models
  locator.registerFactory(() => AnimatedListItemViewModel());

  await initializeServices();
}

/// Initialize other services here that require additional code
/// to run before the services can be registered
Future<void> initializeServices() async {
  final instance = await KeyStorageServiceImpl.getInstance();
  locator.registerSingleton<KeyStorageService>(instance);
}
