import 'dart:io';

import 'package:mime/mime.dart';

List<String> getImages(String path) {
  Directory directory = Directory(path);
  if (!directory.existsSync()) {
    return [];
  } else {
    return directory
        .listSync()
        .whereType<File>()
        .where((element) => lookupMimeType(element.absolute.path)?.startsWith("image") ?? false)
        .map((element) => element.absolute.path)
        .toList();
  }
}

int countImages(String path) {
  Directory directory = Directory(path);
  if (!directory.existsSync()) {
    return -1;
  } else {
    return directory
        .listSync()
        .whereType<File>()
        .where((element) => lookupMimeType(element.absolute.path)?.startsWith("image") ?? false)
        .length;
  }
}

String? getFirstImage(String path) {
  Directory directory = Directory(path);
  if (!directory.existsSync()) {
    return null;
  } else {
    final items =  directory
        .listSync()
        .whereType<File>()
        .where((element) => lookupMimeType(element.absolute.path)?.startsWith("image")  ?? false)
        .map((element) => element.absolute.path).toList();

    if (items.length == 0) {
      return null;
    } else {
      return items.first;
    }

  }
}

DateTime? getCreateTime(String path) {
  File file = File(path);
  if (!file.existsSync()) {
    return null;
  } else {
    return FileStat.statSync(path).accessed;
  }
}

DateTime? getUpdateTime(String path) {
  File file = File(path);
  if (!file.existsSync()) {
    return null;
  } else {
    return FileStat.statSync(path).modified;
  }
}