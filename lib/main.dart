import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Around The Frog')),
        body: Cube(
          onSceneCreated: (Scene scene) {
            scene.world.add(Object(fileName: 'assets/teapot.obj'));
            scene.camera.zoom = 10;
          },
        ),
      ),
    );
  }
}
