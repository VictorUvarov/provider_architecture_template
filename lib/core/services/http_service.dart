import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
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
  /// - if successful: returns decoded json data
  ///
  /// - throws `HttpException` if GET fails
  Future<dynamic> getHttp(String route) async {
    Response response;

    print('(TRACE) Sending GET to ${_dio.options.baseUrl}/$route');

    try {
      response = await _dio.get(route);
    } catch (e) {
      throw HttpException(HttpExceptionMessages.general);
    }

    httpUtils.checkForHttpExceptions(response);

    final data = json.decode(response.data);

    return data;
  }

  /// Send POST request with [body] to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `HttpException` if POST request fails
  Future<dynamic> postHttp(String route, dynamic body) async {
    Response response;

    print('(TRACE) Sending $body to ${_dio.options.baseUrl}/$route');

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

    final data = json.decode(response.data);

    return data;
  }

  /// Send POST request with [files] to endpoint/[route] and return the `response`
  /// - if successful: returns decoded json data
  ///
  /// - throws `HttpException` if posting form fails
  Future<dynamic> postHttpForm(
    String route,
    Map<String, dynamic> body,
    List<File> files,
  ) async {
    Response response;
    int index = 0;

    files.forEach((file) async {
      final uploadInfo = await fileUtils.convertFileToMultipartFile(file);

      body.addAll({'file$index': uploadInfo});

      index++;
    });

    FormData formData = FormData.fromMap(body);

    response = await postHttp(route, formData);

    final data = json.decode(response.data);

    return data;
  }

  /// Download file from [fileUrl] and return the File
  ///
  /// - throws `HttpException` if file download fails
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
