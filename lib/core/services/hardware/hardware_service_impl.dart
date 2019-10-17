import 'dart:io';

import 'package:device_info/device_info.dart';
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
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _udid = iosInfo.identifierForVendor;
      _operatingSystem = "iOS";
      _device = iosInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _udid = androidInfo.androidId;
      _operatingSystem = "Android";
      _device = androidInfo.model;
    }

    print("udid: $_udid");
    print("operating_system: $_operatingSystem");
    print("device: $_device");
  }
}
