import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:provider_start/core/services/hardware/hardware_service.dart';

/// Service that is responsible for getting hardware device info
class HardwareServiceImpl implements HardwareService {
  String _operatingSystem;
  String _device;
  String _udid;

  @override
  String get operatingSystem => _operatingSystem;

  @override
  String get device => _device;

  @override
  String get udid => _udid;

  @override
  Future<void> init() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      _udid = iosInfo.identifierForVendor;
      _operatingSystem = 'iOS';
      _device = iosInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      _udid = androidInfo.androidId;
      _operatingSystem = 'Android';
      _device = androidInfo.model;
    }

    debugPrint('udid: $_udid');
    debugPrint('operating_system: $_operatingSystem');
    debugPrint('device: $_device');
  }
}
