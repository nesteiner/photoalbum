import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photoalbum/model/album.dart';
import 'package:photoalbum/page/photopage.dart';
import 'package:photoalbum/util/getimages.dart';
import 'package:photoalbum/widget/sidebar.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Photo Album",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Album> albums = [];
  Directory? currentDirectory = null;
  @override
  Widget build(BuildContext context) {
    final children = albums.map((album) => SidebarItem(
        album: album,
        onPressed: () {
          onPressed(Directory(album.path));
          Navigator.of(context).pop();
        }
    )).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Photo Album")),
      body: buildGridView(context, currentDirectory),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
                shrinkWrap: true,
                children: children
            ),

            SidebarAdd(
                onAdd: (album) {
                  setState(() {
                    albums.add(album);
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget buildGridView(BuildContext context, Directory? directory) {
    if (directory == null || directory.existsSync() == false) {
      return Container(

      );
    } else {
      final imageUrls = getImages(directory!).map((element) =>
      element.absolute.path).toList();
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => buildImage(context, imageUrls[index]),
      );
    }
  }

  Widget buildImage(BuildContext context, String path) {
    final image = Image.file(
      File(path),
      width: 150,
      fit: BoxFit.cover,
    );

    final container = Container(
      margin: const EdgeInsets.all(2.0),
      child: image,
    );

    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (_) => AlertDialog(content: Image.file(File(path)),));
      },

      child: container,
    );
  }

  void onPressed(Directory directory) {
    setState(() {
      currentDirectory = directory;
    });

  }
}
