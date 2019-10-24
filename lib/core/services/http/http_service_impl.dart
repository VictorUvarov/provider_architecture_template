import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/constant/network_exception_messages.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';
import 'package:provider_start/core/services/http/http_service.dart';
import 'package:provider_start/core/utils/file_utils.dart' as fileUtils;
import 'package:provider_start/core/utils/network_utils.dart' as networkUtils;

/// Helper service that abstracts away common HTTP Requests
class HttpServiceImpl implements HttpService {
  final _dio = Dio();

  /// Send GET request to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `NetworkException` if GET fails
  @override
  Future<dynamic> getHttp(String route) async {
    Response response;

    debugPrint('(TRACE) Sending GET to ${ApiRoutes.base_url}/$route');

    try {
      final fullRoute = '${ApiRoutes.base_url}/$route';
      response = await _dio.get(
        fullRoute,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } catch (_) {
      throw NetworkException(NetworkExceptionMessages.general);
    }

    networkUtils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  /// Send POST request with [body] to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `NetworkException` if POST request fails
  @override
  Future<dynamic> postHttp(String route, dynamic body) async {
    Response response;

    debugPrint('(TRACE) Sending $body to ${ApiRoutes.base_url}/$route');

    try {
      final fullRoute = '${ApiRoutes.base_url}/$route';
      response = await _dio.post(
        fullRoute,
        data: body,
        onSendProgress: networkUtils.showLoadingProgress,
        onReceiveProgress: networkUtils.showLoadingProgress,
        options: Options(
          contentType: 'application/json',
        ),
      );
    } catch (_) {
      throw NetworkException(NetworkExceptionMessages.general);
    }

    networkUtils.checkForNetworkExceptions(response);

    // For this specific API its decodes json for us
    return response.data;
  }

  /// Send POST request with [files] to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `NetworkException` if posting form fails
  @override
  Future<dynamic> postHttpForm(
    String route,
    Map<String, dynamic> body,
    List<File> files,
  ) async {
    int index = 0;

    final formData = FormData.fromMap(body);
    files?.forEach((file) async {
      final mFile = await fileUtils.convertFileToMultipartFile(file);
      formData.files.add(MapEntry('file$index', mFile));
      index++;
    });

    final data = await postHttp(route, formData);

    return data;
  }

  /// Download file from [fileUrl] and return the File
  ///
  /// - throws `NetworkException` if file download fails
  @override
  Future<File> downloadFile(String fileUrl) async {
    Response response;

    final file = await fileUtils.getFileFromUrl(fileUrl);

    try {
      response = await _dio.download(
        fileUrl,
        file.path,
        onReceiveProgress: networkUtils.showLoadingProgress,
      );
    } catch (_) {
      throw NetworkException(NetworkExceptionMessages.general);
    }

    networkUtils.checkForNetworkExceptions(response);

    return file;
  }
}
