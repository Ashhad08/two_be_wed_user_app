import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../utils/backend_configs.dart';
import '../models/hall_model.dart';
import '../models/user_model.dart';

class SystemServices {
  Stream<List<HallModel>> fetchAllHalls() {
    return BackEndConfigs.hallsCollectionsRef.snapshots().map((event) => event
        .docs
        .map((e) => HallModel.fromJson(e.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<UserModel> fetchCurrentUser() {
    return BackEndConfigs.usersCollectionsRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) =>
            UserModel.fromJson(event.data() as Map<String, dynamic>));
  }

  Future<List<Timestamp>> fetchHallBookingsTimes() async {
    return BackEndConfigs.hallBookingsCollectionRef.get().then((value) =>
        value.docs.map((e) => e.get("bookingDateTime") as Timestamp).toList());
  }

  Future<void> sendPushNotification({
    required String token,
    required String date,
    required String userName,
  }) async {
    try {
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization":
                "key=AAAAfXNlwzc:APA91bGVlLEDj8kdsBapn_w5UTnImGHOUWsww-OvHq30iR91Kc-LuY2ENd4hnH534mbBZgCZFmKB5i5ZfXvktj9nBODSObReYxkEvmyI1aa4Agwe4Y2uMFIIbVAkpYoxjT5uWz6P2Mwp"
          },
          body: jsonEncode(<String, dynamic>{
            "to": token,
            "notification": {
              "body": "Hi you have a booking of your hall by $userName",
              "title": "Booking on $date",
              "android_channel_id": "twoBeWedd",
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "sound": true
            },
            "priority": "high",
          }));
    } catch (e) {
      debugPrint("sendPushNotificationError :${e.toString()}");
    }
  }
}
