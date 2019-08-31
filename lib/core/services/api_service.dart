import 'dart:convert';

import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/services/hardware_service.dart';
import 'package:provider_start/core/services/http_service.dart';
import 'package:provider_start/locator.dart';

class ApiService {
  final _hardwareService = locator<HardwareService>();
  final _httpService = locator<HttpService>();

  Future<void> init() async {
    await _hardwareService.init();

    _httpService.init();
  }

  Future<void> sampleGet() async {
    // final locationData = await _locationService.getLocation();

    final body = {
      'udid': _hardwareService.udid,
      // 'lat': locationData.latitude,
      // 'long': locationData.longitude,
    };

    final response = await _httpService.getHttp(ApiRoutes.Sample);

    if (response.statusCode == 200) {
      var parsed = json.decode(response.data);
    }
  }

  Future<void> samplePost() async {
    // final locationData = await _locationService.getLocation();

    final body = {
      'udid': _hardwareService.udid,
      // 'lat': locationData.latitude,
      // 'long': locationData.longitude,
    };

    final response = await _httpService.postHttp(ApiRoutes.Sample, body);

    if (response.statusCode == 200) {
      var parsed = json.decode(response.data);
    }
  }
}
