import 'dart:io';

import 'package:device_info/device_info.dart';

class HardwareService {
  String operatingSystem;
  String device;
  String udid;

  Future<void> init() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      udid = iosInfo.identifierForVendor;
      operatingSystem = "iOS";
      device = iosInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      udid = androidInfo.androidId;
      operatingSystem = "Android";
      device = androidInfo.model;
    }

    print("udid: $udid");
    print("operating_system: $operatingSystem");
    print("device: $device");
  }
}
