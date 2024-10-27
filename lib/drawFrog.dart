import 'package:around_the_frog/main.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';

class DrawFrog extends StatefulWidget {
  var storage = MainApp.storage;
  @override
  _DrawFrog createState() => _DrawFrog();
}

class _DrawFrog extends State<DrawFrog> {
  @override
  Widget build(BuildContext context) {
    return Cube(
      onSceneCreated: (Scene scene) {
        scene.world.add(Object(
            fileName: 'assets/teapot.obj')); //todo: change to online obj fetch
        scene.camera.zoom = 5;
      },
    );
  }
}
