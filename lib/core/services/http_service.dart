import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:provider_start/core/constant/api_routes.dart';
import 'package:path_provider/path_provider.dart';

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

  /// Send POST request with [files] to endpoint/[route] and return the `response`
  Future<Response> postHttpForm(
    String route,
    Map<String, dynamic> body,
    List<File> files,
  ) async {
    Response response;
    int index = 0;

    files.forEach((file) {
      String fileBaseName = basename(file.path);
      String mimeType = lookupMimeType(fileBaseName);
      ContentType contentType = ContentType.parse(mimeType);

      body.addAll({
        'file$index': UploadFileInfo(
          file,
          fileBaseName,
          contentType: contentType,
        ),
      });

      index++;
    });

    FormData formData = FormData.from(body);

    response = await postHttp(route, formData);

    return response;
  }

  /// Download file from [fileUrl] and return the File
  Future<File> downloadFile(String fileUrl) async {
    final directory = await getApplicationDocumentsDirectory();

    String dir = directory.path;

    File file = File('$dir/${basename(fileUrl)}');

    await _dio.download(
      fileUrl,
      file.path,
      onReceiveProgress: _progress,
    );

    return file;
  }

  void _progress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + '%');
    }
  }
}
