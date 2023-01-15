import 'dart:io';

class Photo {
  late String name;
  final String path;
  late DateTime createTime;
  late DateTime updateTime;

  Photo({
    required this.path,
  }) {
    File file = File(this.path);
    final stat = FileStat.statSync(this.path);
    createTime = stat.accessed;
    updateTime = stat.modified;
    name = file.path.split("/").last;
  }
}