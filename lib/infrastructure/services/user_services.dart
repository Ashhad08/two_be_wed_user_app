import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd_user_app/infrastructure/models/hall_booking_model.dart';

import '../../utils/backend_configs.dart';
import '../../utils/utils.dart';
import '../models/user_model.dart';
import '../providers/loading_helper.dart';

class UserServices {
  Future registerUser(
      {required UserModel userModel, required BuildContext context}) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      return await BackEndConfigs.usersCollectionsRef
          .doc(userModel.uid)
          .set(userModel.toJson());
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: e.message ?? '',
          color: Theme.of(context).colorScheme.error);
      return;
    }
  }

  Future updateUserNotificationToken({
    required BuildContext context,
    required String? token,
    required String uid,
  }) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      return await BackEndConfigs.usersCollectionsRef.doc(uid).update({
        "notificationToken": token,
      });
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: e.message ?? '',
          color: Theme.of(context).colorScheme.error);
      return;
    }
  }

  Future updateUserProfile({
    required BuildContext context,
    required String name,
    required String phoneNumber,
    required String uid,
  }) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      return await BackEndConfigs.usersCollectionsRef.doc(uid).update({
        "name": name,
        "phoneNumber": phoneNumber,
      });
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: e.message ?? '',
          color: Theme.of(context).colorScheme.error);
      return;
    }
  }

  Future<void> bookHall(
      {required HallBookingModel bookingModel,
      required BuildContext context}) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      DocumentReference ref = BackEndConfigs.hallBookingsCollectionRef.doc();
      return await ref.set(bookingModel.toJson(ref.id));
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: e.message ?? '',
          color: Theme.of(context).colorScheme.error);
      return;
    }
  }
}
