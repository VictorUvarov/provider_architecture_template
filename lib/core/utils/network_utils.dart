import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:provider_start/core/constant/network_exception_messages.dart';
import 'package:provider_start/core/exceptions/network_exception.dart';

void checkForNetworkExceptions(Response response) {
  switch (response.statusCode) {
    case 401:
      throw NetworkException(NetworkExceptionMessages.code401);
    case 403:
      throw NetworkException(NetworkExceptionMessages.code403);
    case 404:
      throw NetworkException(NetworkExceptionMessages.code404);
    case 500:
      throw NetworkException(NetworkExceptionMessages.code500);
    case 503:
      throw NetworkException(NetworkExceptionMessages.code503);
  }
}

void showLoadingProgress(received, total) {
  if (total != -1) {
    debugPrint('${(received / total * 100).toStringAsFixed(0)}%');
  }
}

dynamic decodeResponseBodyToJson(String body) {
  try {
    final data = convert.jsonDecode(body);
    return data;
  } catch (e) {
    throw NetworkException(NetworkExceptionMessages.jsonFormat);
  }
}
