import 'dart:io';

import 'package:dio/dio.dart';
import 'package:provider_start/core/constant/http_exception_messages.dart';

void checkForHttpExceptions(Response response) {
  switch (response.statusCode) {
    case 401:
      throw HttpException(HttpExceptionMessages.code401);
    case 403:
      throw HttpException(HttpExceptionMessages.code403);
    case 404:
      throw HttpException(HttpExceptionMessages.code404);
    case 500:
      throw HttpException(HttpExceptionMessages.code500);
    case 503:
      throw HttpException(HttpExceptionMessages.code503);
  }
}

void showLoadingProgress(received, total) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + '%');
  }
}
