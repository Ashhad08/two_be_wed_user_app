import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/storage_services.dart';

class ProfileImageProvider extends ChangeNotifier {
  bool _profileImageLoading = false;

  String? _profileImage;

  bool get profileImageLoading => _profileImageLoading;

  String? get profileImage => _profileImage;

  set profileImage(String? value) {
    _profileImage = value;
    notifyListeners();
  }

  final StorageServices _storageServices = StorageServices();

  Future<void> userprofileImage(BuildContext context,
      {required ImageSource source}) async {
    _profileImageLoading = true;
    notifyListeners();
    _profileImage = await _storageServices.uploadImage(
      source: source,
      context: context,
    );
    _profileImageLoading = false;
    notifyListeners();
  }
}
