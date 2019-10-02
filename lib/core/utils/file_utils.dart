import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

Future<String> getApplicationDocumentsDirectoryPath() async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<String> getTemporaryDirectoryPath() async {
  final directory = await getTemporaryDirectory();

  return directory.path;
}

Future<String> getExternalStorageDirectoryPath() async {
  final directory = await getExternalStorageDirectory();

  return directory.path;
}

UploadFileInfo convertFileToUploadInfo(File file) {
  String fileBaseName = basename(file.path);
  String mimeType = lookupMimeType(fileBaseName);
  ContentType contentType = ContentType.parse(mimeType);

  return UploadFileInfo(
    file,
    fileBaseName,
    contentType: contentType,
  );
}
