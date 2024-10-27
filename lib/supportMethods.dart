import 'package:url_launcher/url_launcher.dart';
import 'package:around_the_frog/main.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SupportMethods {
  void openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Object> getFrog(online) async {
    final ref = MainApp.storageRef.child('frogs');
    final ListResult result = await ref.listAll();
    final url = await result.items.first.getDownloadURL();

    var frog = null; //todo: download frog obj
    return frog;
  }
}
