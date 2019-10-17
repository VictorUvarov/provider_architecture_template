import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/services/api/api_service.dart';
import 'package:provider_start/core/services/hardware/hardware_service.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/locator.dart';

/// Example HTTP api service that uses [HttpService]
class ApiServiceImpl implements ApiService {
  final _hardwareService = locator<HardwareService>();
  final _httpService = locator<HttpService>();

  @override
  Future<void> init() async {
    await _hardwareService.init();
  }

  @override
  Future<void> sampleGet() async {
    final body = {
      'udid': _hardwareService.udid,
    };

    final jsonData = await _httpService.getHttp(ApiRoutes.sample);
  }

  @override
  Future<void> samplePost() async {
    final body = {
      'udid': _hardwareService.udid,
    };

    final jsonData = await _httpService.postHttp(ApiRoutes.sample, body);
  }
}
