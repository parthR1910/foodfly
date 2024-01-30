import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:food_fly/ui/utils/widgets/helper.dart';

class StorageService {
  StorageService._private();

  static StorageService service = StorageService._private();

  final fireStorage = firebase_storage.FirebaseStorage.instance;

  Future<String> storeUserProfile(BuildContext context, File file, String filename) async {
    try {
      final baseName = basename(file.path);
      final imgUrl = fireStorage.ref("UserProfile/$baseName");
      await imgUrl.putFile(file);
      return imgUrl.getDownloadURL();
    } on FirebaseAuthException catch (e) {
      return showSnackBar(context: context, error: e.message.toString());
    }
  }
}
