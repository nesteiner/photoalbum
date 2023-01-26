import 'package:flutter/material.dart';
import 'package:photoalbum/models/album.dart';
import 'package:tuple/tuple.dart';
import 'package:photoalbum/dao/albumdao.dart';

class GlobalState with ChangeNotifier {
  AlbumDao albumDao;
  late List<Album> albums;
  Tuple2<String, String>? currentNameAndPath;

  GlobalState({
    required this.albumDao
  });

  Future<void> loadData() async {
    albums = await albumDao.findAll();
    currentNameAndPath = null;
  }

  static Future<GlobalState> newInstanceAsync({required AlbumDao albumDao}) async {
    final state = GlobalState(albumDao: albumDao);
    await state.loadData();

    return state;
  }

  void setNameAndPath(Tuple2<String, String> nameAndPath) {
    currentNameAndPath = nameAndPath;
    notifyListeners();
  }

  Future<void> insert(Tuple2<String, String> data) async {
    final album = Album(name: data.item1, path: data.item2);
    final id = await albumDao.insertOne(album);
    album.id = id;
    albums.add(album);

    notifyListeners();
  }

  Future<void> removeAt(int index) async {
    final album = albums[index];
    albums.removeAt(index);
    await albumDao.deleteOne(album);
    notifyListeners();
  }

  Future<void> renameAt(int index, String name) async {
    // listOfNameAndPath[index] = Tuple2(name, listOfNameAndPath[index].item2);
    albums[index].name = name;
    await albumDao.updateOne(albums[index]);
    notifyListeners();
  }
}