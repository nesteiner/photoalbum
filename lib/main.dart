import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photoalbum/dao/albumdao.dart';
import 'package:photoalbum/database.dart';
import 'package:photoalbum/pages/albumpage.dart';
import 'package:photoalbum/state/globalstate.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: loadGlobalStateAsync(),
        builder: (_, AsyncSnapshot<GlobalState> snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              create: (_) => snapshot.requireData,
              child: Consumer<GlobalState>(
                builder: (context, state, child) => AlbumPage(data: state.albums),
              ),
            );
          } else {
            return LoadingPage();
          }
        },
      )

    );
  }

  Future<AlbumDao> loadAlbumDao() async {
    final directory = await getApplicationSupportDirectory();
    final path = directory.path + "/photoalbum.db";
    final database = await $FloorAppDatabase.databaseBuilder(path).build();
    return database.albumdao;
  }

  Future<GlobalState> loadGlobalStateAsync() async {
    final dao = await loadAlbumDao();
    return await GlobalState.newInstanceAsync(albumDao: dao);
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}