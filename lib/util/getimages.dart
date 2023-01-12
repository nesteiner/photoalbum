import 'dart:io';

import 'package:mime/mime.dart';

List<File> getImages(Directory directory) {
  List<FileSystemEntity> entities = directory.listSync();
  return entities
      .where((element) => lookupMimeType(element.absolute.path)?.startsWith("image") ?? false)
      .whereType<File>().toList();
}