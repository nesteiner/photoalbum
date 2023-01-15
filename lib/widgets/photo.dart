import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photoalbum/models/photo.dart';

class PhotoWidget extends StatelessWidget {
  static final double width = 150.0;
  static final double height = 150.0;

  final Photo photo;

  PhotoWidget({
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    final image = Image.file(
      File(photo.path),
      fit: BoxFit.cover,
      width: width,
      height: height,
    );

    return GestureDetector(
      onTap: () {
        onPressed(context);
      },

      child: image,
    );
  }

  void onPressed(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(photo.name),
      content: Image.file(File(photo.path), fit: BoxFit.cover,),
    ));
  }
}