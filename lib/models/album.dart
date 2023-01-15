import 'package:floor/floor.dart';
import 'package:photoalbum/utils/getimages.dart';

@Entity(tableName: "Album")
class Album {
  @PrimaryKey(autoGenerate: true)
  int? id;

  late String? cover;
  String name;
  String path;
  late int count;

  Album({
    required this.name,
    required this.path
  }) {
    cover = getFirstImage(this.path);
    count = countImages(this.path);
  }
}