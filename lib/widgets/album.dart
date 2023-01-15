import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photoalbum/models/album.dart';

class AlbumWidget extends StatelessWidget {
  static final double width = 400.0;
  static final double height = 400.0;

  final Album album;

  AlbumWidget({
    required this.album
  });

  @override
  Widget build(BuildContext context) {
    final coverWidget = album.cover == null ? Container(decoration: const BoxDecoration(color: Colors.grey), width: width, height: height,)
        : Image.file(File(album.cover!), height: height, width: width, fit: BoxFit.cover,);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          coverWidget,
          Text(album.name, style: const TextStyle(color: Colors.black),),
          Text(album.count.toString(), style: const TextStyle(color: Colors.grey),)
        ],
      );
  }
}