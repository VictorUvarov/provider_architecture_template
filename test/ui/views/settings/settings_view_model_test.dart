import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider_start/core/constant/local_keys.dart';
import 'package:provider_start/core/models/alert_request/confirm_alert_request.dart';
import 'package:provider_start/core/models/alert_response/confirm_alert_response.dart';
import 'package:provider_start/core/models/snack_bar_request/confirm_snack_bar_request.dart';
import 'package:provider_start/core/models/snack_bar_response/confirm_snack_bar_response.dart';
import 'package:provider_start/core/services/app_settings/app_settings_service.dart';
import 'package:provider_start/core/services/auth/auth_service.dart';
import 'package:provider_start/core/services/dialog/dialog_service.dart';
import 'package:provider_start/core/services/key_storage/key_storage_service.dart';
import 'package:provider_start/core/services/navigation/navigation_service.dart';
import 'package:provider_start/core/services/snackbar/snack_bar_service.dart';
import 'package:provider_start/core/utils/logger.dart';
import 'package:provider_start/locator.dart';
import 'package:provider_start/ui/views/settings/settings_view_model.dart';

class MockKeyStorageService extends Mock implements KeyStorageService {}

class MockKeyAppSettingsService extends Mock implements AppSettingsService {}

class MockSnackBarService extends Mock implements SnackBarService {}

class MockDialogService extends Mock implements DialogService {}

class MockNavigationService extends Mock implements NavigationService {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  SettingsViewModel settingsViewModel;
  KeyStorageService mockKeyStorageService;
  AppSettingsService mockKeyAppSettingsService;
  SnackBarService mockSnackBarService;
  DialogService mockDialogService;
  NavigationService mockNavigationService;
  AuthService mockAuthService;

  ConfirmAlertRequest alertRequest;
  ConfirmAlertResponse alertResponse;

  setUp(() {
    setupLogger(test: true);
    setupLocator(test: true);
    locator.allowReassignment = true;
    mockKeyStorageService = MockKeyStorageService();
    mockKeyAppSettingsService = MockKeyAppSettingsService();
    mockSnackBarService = MockSnackBarService();
    mockDialogService = MockDialogService();
    mockNavigationService = MockNavigationService();
    mockAuthService = MockAuthService();

    locator.registerSingleton<KeyStorageService>(mockKeyStorageService);
    locator.registerSingleton<AppSettingsService>(mockKeyAppSettingsService);
    locator.registerSingleton<SnackBarService>(mockSnackBarService);
    locator.registerSingleton<DialogService>(mockDialogService);
    locator.registerSingleton<NavigationService>(mockNavigationService);
    locator.registerSingleton<AuthService>(mockAuthService);

    settingsViewModel = SettingsViewModel();
  });

  void mockHasNotificationsEnabled() {
    when(mockKeyStorageService.hasNotificationsEnabled).thenReturn(true);
  }

  void mockSignOutAlertCalledAndConfirmed() {
    alertRequest = ConfirmAlertRequest(
      (r) => r
        ..title = LocalKeys.settings_view_sign_out
        ..description = LocalKeys.settings_view_sign_out_desc
        ..buttonTitle = LocalKeys.button_confirm,
    );
    alertResponse = ConfirmAlertResponse(
      (r) => r..confirmed = true,
    );
    when(mockDialogService.showDialog(alertRequest))
        .thenAnswer((_) async => alertResponse);
  }

  void mockSignOutAlertCalledAndDenied() {
    alertRequest = ConfirmAlertRequest(
      (r) => r
        ..title = LocalKeys.settings_view_sign_out
        ..description = LocalKeys.settings_view_sign_out_desc
        ..buttonTitle = LocalKeys.button_confirm,
    );
    alertResponse = ConfirmAlertResponse(
      (r) => r..confirmed = false,
    );
    when(mockDialogService.showDialog(alertRequest))
        .thenAnswer((_) async => alertResponse);
  }

  group('init', () {
    test('when view model is created notificationsEnabled is false', () {
      // arrange

      // act

      // assert
      expect(settingsViewModel.notificationsEnabled, false);
    });

    test('when init() is called notificationsEnabled is true', () async {
      // arrange
      mockHasNotificationsEnabled();

      // act
      await settingsViewModel.init();

      // assert
      expect(settingsViewModel.notificationsEnabled, true);
    });

    test('when init() is called UI gets updated', () async {
      // arrange
      var updated = false;
      settingsViewModel.addListener(() => updated = true);

      // act
      await settingsViewModel.init();

      // assert
      expect(updated, true);
    });
  });

  group('openAppSettings', () {
    test('when called AppSettingsService.openAppSettings() is called',
        () async {
      // arrange
      when(mockKeyAppSettingsService.openAppSettings())
          .thenAnswer((_) async => Null);

      // act
      await settingsViewModel.openAppSettings();

      // assert
      verify(mockKeyAppSettingsService.openAppSettings()).called(1);
    });
  });

  group('toggleNotificationsEnabled()', () {
    test('when called notificationsEnabled is toggled', () async {
      expect(settingsViewModel.notificationsEnabled, false);
      await settingsViewModel.toggleNotificationsEnabled();
      expect(settingsViewModel.notificationsEnabled, true);
      await settingsViewModel.toggleNotificationsEnabled();
      expect(settingsViewModel.notificationsEnabled, false);
    });

    test('when called ui is updated', () async {
      // arrange
      var updated = false;
      settingsViewModel.addListener(() => updated = true);

      // act
      await settingsViewModel.toggleNotificationsEnabled();

      // assert
      expect(updated, true);
    });
  });

  group('showSnackbar()', () {
    test('when snackbar request is sent, showSnackBar is called', () async {
      // arrange
      final request = ConfirmSnackBarRequest(
        (r) => r
          ..message = LocalKeys.snackbar_message
          ..buttonText = LocalKeys.snackbar_action,
      );
      final response = ConfirmSnackBarResponse(
        (r) => r..confirmed = true,
      );
      when(mockSnackBarService.showSnackBar(request))
          .thenAnswer((_) async => response);

      // act
      await settingsViewModel.showSnackbar();

      // assert
      verify(mockSnackBarService.showSnackBar(request)).called(1);
    });
  });

  group('signOut()', () {
    test('when called confirm alert dialog with sign out locales is shown',
        () async {
      // arrange
      mockSignOutAlertCalledAndConfirmed();

      // act
      await settingsViewModel.signOut();

      // assert
      verify(mockDialogService.showDialog(alertRequest)).called(1);
    });

    test('when called and alert confirmed authService.signOut() is called',
        () async {
      // arrange
      mockSignOutAlertCalledAndConfirmed();

      // act
      await settingsViewModel.signOut();

      // assert
      verify(mockAuthService.signOut()).called(1);
    });

    test('when called and alert denied authService.signOut() is never called',
        () async {
      // arrange
      mockSignOutAlertCalledAndDenied();

      // act
      await settingsViewModel.signOut();

      // assert
      verifyNever(mockAuthService.signOut());
    });
  });
}
