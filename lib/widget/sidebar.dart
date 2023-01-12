import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photoalbum/model/album.dart';

class SidebarItem extends StatelessWidget {
  final Album album;
  final void Function() onPressed;

  const SidebarItem({
    required this.album,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final container = Container(
      padding: const EdgeInsets.all(3.0),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.lightBlue, width: 1),
      ),

      child: Center(
        child: Text(album.title, style: const TextStyle(color: Colors.black),)
      )

    );

    return GestureDetector(
      onTap: onPressed,
      child: container,
    );
  }
}

class SidebarAdd extends StatelessWidget {
  TextEditingController directoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final void Function(Album) onAdd;

  SidebarAdd({required this.onAdd});

  @override
  Widget build(BuildContext context) {
     return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.lightBlue, width: 1),
        borderRadius: BorderRadius.circular(5.0)
      ),

      child: Center(
        child: IconButton(onPressed: () {onPressed(context);}, icon: Icon(Icons.add))
      ),
    );
  }

  void onPressed(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Add Album"),
      content: Center(
        child: Column(
          children: [
            TextField(
              controller: directoryController,
              decoration: InputDecoration(
                hintText: "input directory to walk"
              ),
            ),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "input name of this album"
              ),
            )
          ],
        ),
      ),

      actions: [
        TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text("cacncel")),
        TextButton(
            onPressed: () {
              final album = Album(title: titleController.text, path: directoryController.text);
              onAdd(album);
              Navigator.of(context).pop(true);
            },
            child: Text("confirm"))
      ],
    ));
  }
}