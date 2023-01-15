import 'package:flutter/material.dart';
import 'package:photoalbum/models/photo.dart';
import 'package:photoalbum/utils/getimages.dart';
import 'package:photoalbum/widgets/photo.dart';

enum SortBy {
  byName,
  byCreateTime,
  byUpdateTime,
}

class PhotoPage extends StatefulWidget {
  final List<String> imageUrls;
  final String name;
  PhotoPage({
    required this.name,
    required this.imageUrls
  });

  PhotoPageState createState() => PhotoPageState();
}

class PhotoPageState extends State<PhotoPage> {
  void initState() {
    setState(() {
      sortImageUrls(SortBy.byName);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name), actions: buildActions(context),),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
      children: widget.imageUrls.map((element) => Container(
        margin: const EdgeInsets.all(3.0),
        child: PhotoWidget(photo: Photo(path: element),),
      )).toList(),
    );
  }

  List<Widget> buildActions(BuildContext context) {
    final popup = PopupMenuButton(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(Icons.sort),
        ),
        itemBuilder: (context) => [
          PopupMenuItem<SortBy>(
            child: Text("名称"),
            value: SortBy.byName,
            onTap: () {
              sortImageUrls(SortBy.byName);
            },
        ),
          PopupMenuItem<SortBy>(
            child: Text("创建时间"),
            value: SortBy.byCreateTime,
            onTap: () {
              sortImageUrls(SortBy.byCreateTime);
            },
        ),
          PopupMenuItem<SortBy>(
            child: Text("修改时间"),
            value: SortBy.byUpdateTime,
            onTap: () {
              sortImageUrls(SortBy.byUpdateTime);
            },
        )
    ]);

    return [popup];
  }

  void sortImageUrls(SortBy sortBy) {
    if (sortBy == SortBy.byName) {
      setState(() {
        widget.imageUrls.sort((a, b) {
          final inta = int.parse(a.split("/").last.split(".").first);
          final intb = int.parse(b.split("/").last.split(".").first);
          return inta.compareTo(intb);
        });
      });

    } else if (sortBy == SortBy.byCreateTime) {
      setState(() {
        widget.imageUrls.sort((a, b) {
          final datea = getCreateTime(a);
          final dateb = getCreateTime(b);

          return datea!.compareTo(dateb!);
        });
      });
    } else {
      setState(() {
        widget.imageUrls.sort((a, b) {
          final updatea = getUpdateTime(a);
          final updateb = getUpdateTime(b);

          return updatea!.compareTo(updateb!);
        });
      });
    }
  }
}