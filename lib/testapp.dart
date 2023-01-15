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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildBody(context),
      )
    );
  }

  Widget buildBody(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) => [
      PopupMenuItem(
        child: Text("click me"),
        onTap: () {
          showDialog(context: context, builder: (context) => AlertDialog(
            content: Text("Hello world"),
          ));
        },
      )
    ]);
  }
}