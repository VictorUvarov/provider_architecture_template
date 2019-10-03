import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
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

Future<MultipartFile> convertFileToMultipartFile(File file) async {
  String fileBaseName = basename(file.path);
  String fileType = extension(file.path);

  return await MultipartFile.fromFile(
    file.path,
    filename: '$fileBaseName.$fileType',
  );
}
