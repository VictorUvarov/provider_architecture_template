import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:provider_start/core/constant/http_exception_messages.dart';
import 'package:provider_start/core/utils/file_utils.dart' as fileUtils;
import 'package:provider_start/core/utils/http_utils.dart' as httpUtils;

/// Helper service that abstracts away common HTTP Requests
class HttpService {
  Dio _dio = Dio();

  /// Set default configs
  void init() {
    _dio.options.baseUrl = ApiRoutes.end_point;
    _dio.options.connectTimeout = 5000; // 5 seconds
    _dio.options.receiveTimeout = 3000; // 3 seconds
  }

  /// Send GET request to endpoint/[route] and return the `response`
  Future<Response> getHttp(String route) async {
    Response response;

    debugPrint('Sending GET to ${ApiRoutes.end_point}/$route');

    try {
      response = await _dio.get(route);
    } catch (e) {
      throw HttpException(HttpExceptionMessages.general);
    }

    httpUtils.checkForHttpExceptions(response);

    return response;
  }

  /// Send POST request with [body] to endpoint/[route] and return the `response`
  Future<Response> postHttp(String route, dynamic body) async {
    Response response;

    debugPrint('Sending $body to ${ApiRoutes.end_point}/$route');

    try {
      response = await _dio.post(
        route,
        data: body,
        onSendProgress: httpUtils.showLoadingProgress,
        onReceiveProgress: httpUtils.showLoadingProgress,
      );
    } catch (e) {
      throw HttpException(HttpExceptionMessages.general);
    }

    httpUtils.checkForHttpExceptions(response);

    return response;
  }

  /// Send POST request with [files] to endpoint/[route] and return the `response`
  Future<Response> postHttpForm(
    String route,
    Map<String, dynamic> body,
    List<File> files,
  ) async {
    Response response;
    int index = 0;

    files.forEach((file) {
      final uploadInfo = fileUtils.convertFileToUploadInfo(file);

      body.addAll({'file$index': uploadInfo});

      index++;
    });

    FormData formData = FormData.from(body);

    response = await postHttp(route, formData);

    return response;
  }

  /// Download file from [fileUrl] and return the File
  Future<File> downloadFile(String fileUrl) async {
    Response response;

    final dir = await fileUtils.getApplicationDocumentsDirectoryPath();

    File file = File('$dir/${basename(fileUrl)}');

    try {
      response = await _dio.download(
        fileUrl,
        file.path,
        onReceiveProgress: httpUtils.showLoadingProgress,
      );
    } catch (e) {
      throw HttpException(HttpExceptionMessages.general);
    }

    httpUtils.checkForHttpExceptions(response);

    return file;
  }
}
