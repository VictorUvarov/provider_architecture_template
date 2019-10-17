import 'dart:io';

abstract class HttpService {
  Future<dynamic> getHttp(String route);

  Future<dynamic> postHttp(String route, dynamic body);

  Future<dynamic> postHttpForm(
    String route,
    Map<String, dynamic> body,
    List<File> files,
  );

  Future<File> downloadFile(String fileUrl);
}
