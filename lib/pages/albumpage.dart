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
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final children = widget.data.asMap().map((key, element) =>
        MapEntry(key, buildAlbum(context, key, element))
    ).values.toList();


    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.7),
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

  Widget buildAlbum(BuildContext context, int index, Album data) {
    final state = context.read<GlobalState>();
    final container = Container(
        margin: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                PhotoPage(name: data.name, imageUrls: getImages(data.path))));
          },
          child: Stack(
           children: [
             AlbumWidget(
                 album: Album(name: data.name, path: data.path)),
             Positioned(
                 right: 0,
                 top: 0,
                 child: PopupMenuButton(
                   child: const Icon(Icons.more_horiz, size: 40,),
                   itemBuilder: (context) => [
                     PopupMenuItem(
                       onTap: () {
                         WidgetsBinding.instance.addPostFrameCallback((_) {
                           onPressedEdit(context, index);
                         });
                       },

                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: const [
                           Icon(Icons.edit),
                           SizedBox(width: 15,),
                           Text("编辑")
                         ],
                       ),
                     ),

                     PopupMenuItem(
                       onTap: () {
                         state.removeAt(index);
                       },

                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: const [
                           Icon(Icons.delete, color: Colors.red,),
                           SizedBox(width: 15,),
                           Text("删除")
                         ],
                       )
                     )
                   ],
                 )
             )
           ],
          )
        )
    );

    return container;
  }

  void onPressedEdit(BuildContext context, int index) {
    controller.text = "";
    final state = context.read<GlobalState>();

    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("编辑这个相薄"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: "输入新的相薄名称"
        ),
      ),

      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("cancel")),

        TextButton(
            onPressed: () {
              state.renameAt(index, controller.text);
              Navigator.of(context).pop(true);
            },
            child: const Text("confirm"))
      ],
    ));
  }
}
