import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

Future<String> getApplicationDocumentsDirectoryPath() async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> getFileFromUrl(String url) async {
  final dir = await getApplicationDocumentsDirectoryPath();
  final file = File('$dir/${basename(url)}');

  return file;
}

Future<MultipartFile> convertFileToMultipartFile(File file) async {
  final fileBaseName = basename(file.path);
  final mimeType = lookupMimeType(fileBaseName);
  final contentType = MediaType.parse(mimeType);

  return MultipartFile.fromFileSync(
    file.path,
    filename: fileBaseName,
    contentType: contentType,
  );
}
