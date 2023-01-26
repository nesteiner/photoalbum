import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> urls = [
    "/home/steiner/disk/windows-data/Download/evelyn/[MFStar模范学院] VOL.033 Evelyn艾莉 - 三亚旅拍写真套图/1.jpg",
    "/home/steiner/disk/windows-data/Download/evelyn/[MFStar模范学院] VOL.033 Evelyn艾莉 - 三亚旅拍写真套图/2.jpg",
    "/home/steiner/disk/windows-data/Download/evelyn/[MFStar模范学院] VOL.033 Evelyn艾莉 - 三亚旅拍写真套图/3.jpg",
    "/home/steiner/disk/windows-data/Download/evelyn/[MFStar模范学院] VOL.033 Evelyn艾莉 - 三亚旅拍写真套图/4.jpg",
    "/home/steiner/disk/windows-data/Download/evelyn/[MFStar模范学院] VOL.033 Evelyn艾莉 - 三亚旅拍写真套图/5.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildBody(context)
      )
    );
  }

  Widget buildBody(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.75),
      children: urls.map<Widget>((url) => buildAlbum(context, url)).toList(),
    );
  }

  Widget buildAlbum(BuildContext context, String url) {
    final image = Image.file(File(url), fit: BoxFit.cover,);
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 500,
          height: 500,
          child: image,
        ),
        Text("hello"),
        Text("1")
      ],
    );

    return column;
  }
}