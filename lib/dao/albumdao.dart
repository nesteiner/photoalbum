import 'package:floor/floor.dart';
import 'package:photoalbum/models/album.dart';

@dao
abstract class AlbumDao {
  @Query("select * from Album")
  Future<List<Album>> findAll();

  @insert
  Future<int> insertOne(Album data);

  @update
  Future<void> updateOne(Album data);

  @delete
  Future<void> deleteOne(Album data);
}