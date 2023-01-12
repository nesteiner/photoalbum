import 'dart:io';

import 'package:flutter/material.dart';

class PhotoPage extends StatelessWidget {
  final String path;
  PhotoPage({Key? key, required this.path}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.file(
          File(path)
        ),
      ),
    );
  }
}