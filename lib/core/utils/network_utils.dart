import 'dart:convert' as convert;

import 'package:dio/dio.dart';

import '../exceptions/network_exception.dart';
import 'logger.dart';

void checkForNetworkExceptions(Response response) {
  if (response.statusCode != 200) {
    throw NetworkException('Failed to connect to internet');
  }
}

void showLoadingProgress(received, total) {
  if (total != -1) {
    Logger.d('${(received / total * 100).toStringAsFixed(0)}%');
  }
}

dynamic decodeResponseBodyToJson(String body) {
  try {
    final data = convert.jsonDecode(body);
    return data;
  } on FormatException catch (e) {
    Logger.e('Network Utils: Failed to decode response body ${e.message}');
    throw NetworkException(e.message);
  }
}
