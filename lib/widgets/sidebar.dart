import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photoalbum/utils/getimages.dart';
import 'package:tuple/tuple.dart';

class Sidebar extends StatelessWidget {
  final void Function() onPressedAllAlbums;
  final void Function(Tuple2<String, String>) onPressedOneAlbum;
  final void Function(Tuple2<String, String>) onAddAlbum;
  final List<Tuple2<String, String>> data;
  TextEditingController controller = TextEditingController();

  Sidebar({
    required this.onPressedAllAlbums,
    required this.onPressedOneAlbum,
    required this.onAddAlbum,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    final children = data.map((element) => buildOneAlbum(context, element)).toList();
    children.insert(0, buildAllAlbums(context));
    children.add(buildAddAlbum(context));

    return Column(
      children: [
        Text("我的相薄", style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        Expanded(child: ListView(
          shrinkWrap: true,
          children: children
        ))
      ],
    );
  }

  Widget buildAllAlbums(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("album.png", width: 50, height: 50,),
        SizedBox(width: 15,),
        Text("所有相薄", style: const TextStyle(color: Colors.black),)
      ],
    );

    final container = Container(
      margin: const EdgeInsets.all(5.0),
      child: row,
    );

    return GestureDetector(
      onTap: onPressedAllAlbums,
      child: container,
    );
  }

  Widget buildOneAlbum(BuildContext context, Tuple2<String, String> nameAndPath) {
    final name = nameAndPath.item1;
    final path = nameAndPath.item2;

    final cover = getFirstImage(path);
    final coverWidget = cover == null ? Container(width: 50, height: 50,) : Image.file(File(cover), width: 50, height: 50, fit: BoxFit.cover,);

    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        coverWidget,
        SizedBox(width: 15,),
        Text(name, style: const TextStyle(color: Colors.black),)
      ],
    );

    final container = Container(
      margin: const EdgeInsets.all(5.0),
      child: row,
    );

    return GestureDetector(
      onTap: () {
        onPressedOneAlbum(nameAndPath);
      },
      child: container,
    );
  }

  Widget buildAddAlbum(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.add, size: 50,),
        SizedBox(width: 15,),
        Text("新建相薄",)
      ],
    );

    final container = Container(
      margin: const EdgeInsets.all(5.0),
      child: row,
    );

    return GestureDetector(
      onTap: () {
        onPressedButton(context);
      },

      child: container,
    );
  }

  void onPressedButton(BuildContext context) async {
    String? directory = await FilePicker.platform.getDirectoryPath();
    if (directory != null) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("input album name"),
        content: Center(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "input album name"
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },

            child: Text("cancel"),
          ),

          TextButton(
              onPressed: () {
                onAddAlbum(Tuple2(controller.text, directory));
                Navigator.of(context).pop(true);
              },
              child: Text("confirm")
          )
        ],
      ));
    }
  }
}