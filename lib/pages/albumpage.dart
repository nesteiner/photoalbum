import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photoalbum/models/album.dart';
import 'package:photoalbum/pages/photopage.dart';
import 'package:photoalbum/state/globalstate.dart';
import 'package:photoalbum/utils/getimages.dart';
import 'package:photoalbum/widgets/album.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class AlbumPage extends StatefulWidget {
  final List<Album> data;

  const AlbumPage({
    required this.data
  });

  @override
  AlbumPageState createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  static const double eachHeight = 500.0;
  bool iseditting = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                onPressedAdd(context);
              },

              icon: const Icon(Icons.add)),

          IconButton(
              onPressed: () {
                onPressedEdit(context);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    List<Widget> children = [];
    final state = context.read<GlobalState>();
    if (iseditting) {
      children = widget.data.asMap().map((key, element) =>
      MapEntry(key, Container(
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            AlbumWidget(album: Album(name: element.name, path: element.path)),
            Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red,),
                  onPressed: () {
                    state.removeAt(key);
                  },
                )
            ),
            Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.edit,),
                  onPressed: () {
                    controller.text = "";
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: const Text("编辑这个相薄"),
                      content: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: "输入新的名称",
                        ),
                      ),

                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("cancel")
                        ),

                        TextButton(
                            onPressed: () {
                              state.renameAt(key, controller.text);
                              Navigator.of(context).pop(true);
                            },
                            child: const Text("confirm")
                        )
                      ],
                    ));
                  },
                ))
          ],
        ),
      ))).values.toList();
    } else {
      children = widget.data.asMap().map((key, element) =>
          MapEntry(key, Container(
              margin: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                      PhotoPage(name: element.name, imageUrls: getImages(element
                          .path))));
                },

                onLongPress: () {
                  onLongPress(context, key);
                },
                child: AlbumWidget(
                    album: Album(name: element.name, path: element.path)),
              )
          ))).values.toList();
    }

    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisExtent: eachHeight),
      children: children,
    );
  }

  Future<void> onPressedAdd(BuildContext context) async {
    final state = context.read<GlobalState>();
    String? directory = await FilePicker.platform.getDirectoryPath();
    if (directory != null) {
      controller.text = "";
      showDialog(context: context, builder: (context) =>
          AlertDialog(
            title: const Text("input album name"),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: "输入相薄名称"
                    ),
                  ),
                ]
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },

                child: const Text("cancel"),
              ),

              TextButton(
                  onPressed: () {
                    state.insert(Tuple2(controller.text, directory));
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("confirm")
              )
            ],
          ));
    }
  }

  void onPressedEdit(BuildContext context) {
    setState(() {
      iseditting = !iseditting;
    });
  }

  void onLongPress(BuildContext context, int index) {
    const position = RelativeRect.fill;
    showMenu(
        context: context,
        position: position,
        items: [
          buildDeleteOption(context, index),
          buildEditOption(context, index),
        ]);
  }

  PopupMenuItem buildDeleteOption(BuildContext context, int index) {
    final state = context.read<GlobalState>();
    return PopupMenuItem(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.delete, color: Colors.red,),
          ),

          SizedBox(width: 15,),

          Text("删除", style: TextStyle(color: Colors.black),)
        ],
      ),

      onTap: () {
        state.removeAt(index);
      },
    );
  }

  PopupMenuItem buildEditOption(BuildContext context, int index) {
    final state = context.read<GlobalState>();
    return PopupMenuItem(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Padding(padding: EdgeInsets.all(10.0), child: Icon(Icons.edit, color: Colors.black,),),
          SizedBox(width: 15,),
          Text("编辑", style: TextStyle(color: Colors.black),)
        ],
      ),

      onTap: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.text = "";
          showDialog(context: context, builder: (context) => AlertDialog(
            title: const Text("编辑这个相薄"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "输入新的名称",
              ),
            ),

            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("cancel")
              ),

              TextButton(
                  onPressed: () {
                    state.renameAt(index, controller.text);
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("confirm")
              )
            ],
          ));
        });
      },

    );
  }
}
