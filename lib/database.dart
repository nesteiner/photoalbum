import 'package:floor/floor.dart';
import 'package:photoalbum/dao/albumdao.dart';
import 'package:photoalbum/models/album.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part "database.g.dart";

@Database(version: 1, entities: [Album])
abstract class AppDatabase extends FloorDatabase {
  AlbumDao get albumdao;
}