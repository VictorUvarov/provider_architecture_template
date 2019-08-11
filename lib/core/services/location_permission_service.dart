import 'dart:io';

import 'package:location_permissions/location_permissions.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/locator.dart';

class LocationPermissionService {
  Future<ServiceStatus> checkServiceStatus() async {
    ServiceStatus serviceStatus = await LocationPermissions()
        .checkServiceStatus(level: LocationPermissionLevel.locationWhenInUse);

    return serviceStatus;
  }

  /// Ask for `locationWhenInUse` permission and updates [localStorageService]
  /// to whether the user granted location permissions
  Future<void> requestPermission() async {
    final localStorageService = locator<KeyStorageService>();

    if (Platform.isIOS) {
      final serviceStatus = await checkServiceStatus();

      if (serviceStatus != ServiceStatus.enabled) return;
    }

    final permissionStatus = await LocationPermissions().requestPermissions(
      permissionLevel: LocationPermissionLevel.locationWhenInUse,
    );

    localStorageService.locationGranted =
        permissionStatus == PermissionStatus.granted;
  }

  void openAppPermissions() {
    LocationPermissions().openAppSettings();
  }
}
