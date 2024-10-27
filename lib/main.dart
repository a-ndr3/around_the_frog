import 'package:around_the_frog/AppColors.dart';
import 'package:around_the_frog/AppTextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:firebase_core/firebase_core.dart' as fb_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'countersDisplay.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await fb_core.Firebase.initializeApp(
    options: fb_core.FirebaseOptions(
      apiKey: dotenv.env['API_KEY']!,
      authDomain: dotenv.env['AUTH_DOMAIN']!,
      projectId: dotenv.env['PROJECT_ID']!,
      storageBucket: dotenv.env['STORAGE_BUCKET']!,
      messagingSenderId: dotenv.env['MESSAGING_SENDER_ID']!,
      appId: dotenv.env['APP_ID']!,
    ),
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  static final storage = firebase_storage.FirebaseStorage.instance;
  static final storageRef = storage.ref();
  static final rtdb = FirebaseDatabase.instanceFor(
      app: fb_core.Firebase.app(), databaseURL: dotenv.env['DATABASE_URL']);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        body: Column(
          children: [
            Text(
              'AROUND THE FROG',
              textAlign: TextAlign.center,
              style: AppTextStyles.homePageTitleText,
            ),
            Expanded(
              flex: 1,
              child: Text("FROG SPINNERS",
                  style: AppTextStyles.statisticsTitleText),
            ),
            Expanded(
              flex: 1,
              child: CounterDisplay(),
            ),
            Expanded(
              flex: 3,
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world
                      .add(Object(fileName: 'frog_v2.obj', lighting: true));
                  scene.camera.zoom = 5;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
