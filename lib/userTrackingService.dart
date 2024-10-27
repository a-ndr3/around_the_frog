import 'package:around_the_frog/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class UserTrackingService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DatabaseReference presenceRef = MainApp.rtdb.ref('presence');
  final DatabaseReference connectedRef = MainApp.rtdb.ref('.info/connected');

  Future<String> getUsersID() async {
    final response = await http.get(Uri.parse('https://ipinfo.io/json'));
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String ip = data['ip'];
    return ip.replaceAll('.', '');
  }

  Future<void> handleUsersCounter(String userId) async {
    final response = await http.get(Uri.parse('https://ipinfo.io/json'));
    final Map<String, dynamic> data = jsonDecode(response.body);
    final String country = data['country'];

    final countryDoc = firestore.collection('countries').doc(country);

    connectedRef.onValue.listen((event) async {
      final bool isConnected = event.snapshot.value as bool? ?? false;

      if (isConnected) {
        final userPresenceRef = presenceRef.child(userId);

        userPresenceRef.onDisconnect().set({
          'online': false,
          'last_online': ServerValue.timestamp,
        }).then((_) async {
          firestore.runTransaction((transaction) async {
            DocumentSnapshot snapshot = await transaction.get(countryDoc);

            if (snapshot.exists) {
              int currentOnlineCount = snapshot['online_count'];
              if (currentOnlineCount > 0) {
                transaction.update(countryDoc, {
                  'online_count': currentOnlineCount - 1,
                });
              }
            }
          });

          await userPresenceRef.set({
            'online': true,
            'last_online': ServerValue.timestamp,
          });

          firestore.runTransaction((transaction) async {
            DocumentSnapshot snapshot = await transaction.get(countryDoc);

            if (!snapshot.exists) {
              transaction.set(countryDoc, {
                'online_count': 1,
                'total_count': 1,
              });
            } else {
              transaction.update(countryDoc, {
                'online_count': snapshot['online_count'] + 1,
                'total_count': snapshot['total_count'] + 1,
              });
            }
          });
        });
      }
    });
  }

  Stream<Map<String, int>> getOnlineUsersByCountry() {
    return firestore.collection('countries').snapshots().map((querySnapshot) {
      final Map<String, int> onlineCountryCounts = {};
      querySnapshot.docs.forEach((doc) {
        onlineCountryCounts[doc.id] = doc['online_count'];
      });
      return onlineCountryCounts;
    });
  }

  Stream<Future<int>> getTotalUsersStream() {
    return firestore.collection('countries').snapshots().map((querySnapshot) {
      int total = 0;
      querySnapshot.docs.forEach((doc) {
        var count = doc.exists ? doc['count'] : 0;
        total += count as int;
      });
      return Future.value(total);
    });
  }
}
