import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:provider_start/core/constant/api_routes.dart';

class HttpService {
  Dio _dio = Dio();

  /// Set default configs
  void init() {
    _dio.options.baseUrl = ApiRoutes.EndPoint;
    _dio.options.connectTimeout = 5000; // 5 seconds
    _dio.options.receiveTimeout = 3000; // 3 seconds
  }

  /// Send GET request to endpoint/[route] and return the `response`
  Future<Response> getHttp(String route) async {
    Response response;

    debugPrint('Sending GET to ${ApiRoutes.EndPoint}/$route');

    final future = _dio.get(route);
    future.then((res) => response = res);
    future.catchError((err) => print(err));

    await future;

    debugPrint('response ${response.data}');

    return response;
  }

  /// Send POST request with [body] to endpoint/[route] and return the `response`
  Future<Response> postHttp(String route, dynamic body) async {
    Response response;

    debugPrint('Sending $body to ${ApiRoutes.EndPoint}/$route');

    final future = _dio.post(
      route,
      data: body,
      onSendProgress: _progress,
      onReceiveProgress: _progress,
    );
    future.then((res) => response = res);
    future.catchError((err) => print(err));

    await future;

    debugPrint('response ${response.data}');

    return response;
  }

  void _progress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + '%');
    }
  }
}
